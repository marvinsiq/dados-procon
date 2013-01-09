# encoding: utf-8

@characters = {
  'á' => 'a', 'Á' => 'A',
  'é' => 'e', 'É' => 'E',
  'í' => 'i', 'Í' => 'I',
  'ó' => 'o', 'Ó' => 'O',
  'ú' => 'u', 'Ú' => 'U',
  'ã' => 'a', 'Ã' => 'A',
  'õ' => 'o', 'Õ' => 'O',
  'ê' => 'e', 'Ê' => 'E',
  'ô' => 'o', 'Ô' => 'O',
  'ü' => 'u', 'Ü' => 'U',
  'ç' => 'c', 'Ç' => 'C',
  'à' => 'a', 'À' => 'A'
}

def load_data_from_csv(file)
  data = Array.new
  text = File.read(file)
  csv = CSV.parse(text, :headers => true, :col_sep => ';', :quote_char => '"', :force_quotes => true)
  columns = csv.headers
  
  csv.each do |row|
    row_data = Hash.new
    columns.each do |column|
      row_data[column] = row[column]
    end
    
    data << row_data
  end
  
  data
end

def replace_special_characters(text)
  return text if text.nil?
  
  txt = text.dup
  @characters.each {|k, v| txt.gsub! /#{k}/, v }
  txt
end

def get_tags_without_stopwords(text)
  txt = replace_special_characters text
  return txt if txt.nil?
  
  tags = txt.downcase.split(/[\s\/]/)
  tags.delete_if {|t| STOPWORDS.include? t }
end

def cnpj_zero_fill(cnpj)
  return cnpj if cnpj.nil?
  '0' * (14 - cnpj.size) + cnpj
end

def format_cnpj(cnpj)
  "#{cnpj[0, 2]}.#{cnpj[2, 3]}.#{cnpj[5, 3]}/#{cnpj[8, 4]}-#{cnpj[12, 2]}"
end

def create_tags(row)
  tags = []
  tokens = get_tags_without_stopwords(row[:razao_social])
  tags.concat tokens if tokens
  
  tokens = get_tags_without_stopwords(row[:nome_fantasia])
  if tokens
    tokens.delete_if {|t| tags.include? t }
    tags.concat tokens
  end
  
  row[:cnpjs].each do |cnpj|
    c = cnpj_zero_fill(cnpj)
    if c
      tags << c
      tags << format_cnpj(c)
    end    
  end
  
  tags
end

shell.say 'Populando base de dados do projeto'
shell.say ''

shell.say "Removendo (se existir) documentos da coleção 'reclamacaos'"
Reclamacao.delete_all
shell.say ''

shell.say "Carregando reclamações fundamentadas do arquivo 'db/reclamacoes_fundamentadas_db.csv'"
data = load_data_from_csv 'db/reclamacoes_fundamentadas_db.csv'

empresas = {}
#count = 0
#year = 2009
data.each do |row|
  #if year < row['anocalendario'].to_i
  #  year = row['anocalendario'].to_i
  #  count = 0
  #end
  
  #if count < 100  
  razao_social = replace_special_characters(row['strRazaoSocial'])
  if empresas[razao_social]
    empresas[razao_social] << {:cnpj => row['NumeroCNPJ']}
  else
    empresas[razao_social] = [{
      :nome_fantasia => row['strNomeFantasia'], :cnpj => row['NumeroCNPJ'],
      :cnae_principal => row['DescCNAEPrincipal']
    }]
  end
  #end
  
  #count += 1
end

shell.say "Removendo (se existir) documentos da coleção 'pessoa_juridicas'"
PessoaJuridica.delete_all
shell.say ''

shell.say "Carregando pessoas jurídicas"
empresas.each do |k, v|
  cnpjs = v.map {|e| e[:cnpj] }
  
  PessoaJuridica.create(:razao_social => k, :nome_fantasia => v.first[:nome_fantasia],
                        :cnpj => cnpjs.join(','), :cnae_principal => v.first[:cnae_principal], 
                        :tags => create_tags(:razao_social => k, :nome_fantasia => v.first[:nome_fantasia], :cnpjs => cnpjs))
end

#count = 0
#year = 2009
data.each do |row|
  #if year < row['anocalendario'].to_i
  #  year = row['anocalendario'].to_i
  #  count = 0
  #end
  
  #if count < 100
  pessoa_juridica = PessoaJuridica.where(:cnpj => row['NumeroCNPJ']).first
  Reclamacao.create(:ano_calendario => row['anocalendario'], :data_arquivamento => row['DataArquivamento'],
                    :data_abertura => row['DataAbertura'], :uf => row['UF'],
                    :atendida => row['Atendida'], :codigo_assunto => row['CodigoProblema'],
                    :descricao_assunto => row['DescricaoProblema'],
                    :pessoa_juridica => pessoa_juridica) if pessoa_juridica
  #end
  #count += 1
end

data = nil
empresa = nil
GC.start

shell.say ''
shell.say 'Criando ranking de reclamações'

load('db/complaints_ranking.rb')

shell.say 'Ranking de reclamações concluído'

shell.say ''
shell.say 'Criando arquivo de dados com assuntos de reclamação'

load('db/complaints_subject.rb')

shell.say "Arquivo '.complaint_subjects.yml' criado"

shell.say ''
shell.say 'Povoamento da base de dados concluído'
