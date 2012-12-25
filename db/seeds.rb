# encoding: utf-8

@characters = {
  'á' => 'a',
  'é' => 'e',
  'í' => 'i',
  'ó' => 'o',
  'ú' => 'u',
  'ã' => 'a',
  'õ' => 'o',
  'ê' => 'e',
  'ô' => 'o',
  'ü' => 'u',
  'ç' => 'c',
  'à' => 'a'
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
  
  text.downcase!
  @characters.each {|k, v| text.gsub! /k/, v }
  text
end

def get_tags_without_stopwords(text)
  txt = text.dup
  replace_special_characters txt
  return text if text.nil?
  
  tags = txt.split(/[\s\/]/)
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
  tokens = get_tags_without_stopwords(row['strRazaoSocial'])
  tags.concat tokens if tokens
  
  tokens = get_tags_without_stopwords(row['strNomeFantasia'])
  if tokens
    tokens.delete_if {|t| tags.include? t }
    tags.concat tokens
  end
  
  cnpj = cnpj_zero_fill(row['NumeroCNPJ'])
  tags << cnpj if cnpj
  tags << format_cnpj(cnpj) if cnpj
end

shell.say 'Populando base de dados do projeto'
shell.say ''

shell.say "Removendo (se existir) documentos da coleção 'reclamacaos'"
Reclamacao.delete_all
shell.say ''

shell.say "Carregando reclamações fundamentadas do arquivo 'db/reclamacoes_fundamentadas_db.csv'"
data = load_data_from_csv 'db/reclamacoes_fundamentadas_db.csv'

data.each do |row|
  Reclamacao.create(:ano_calendario => row['anocalendario'], :data_arquivamento => row['DataArquivamento'],
                    :data_abertura => row['DataAbertura'], :regiao => row['regiao'], :uf => row['UF'],
                    :razao_social => row['strRazaoSocial'], :nome_fantasia => row['strNomeFantasia'], :tipo => row['Tipo'],
                    :cnpj => row['NumeroCNPJ'], :cnae_principal => row['DescCNAEPrincipal'], :atendida => row['Atendida'],
                    :codigo_assunto => row['CodigoAssunto'], :descricao_assunto => row['DescricaoAssunto'],
                    :sexo_consumidor => row['SexoConsumidor'], :faixa_etaria_consumidor => row['FaixaEtariaConsumidor'],
                    :cep_consumidor => row['CEPConsumidor'], :tags => create_tags(row))
end

shell.say ''
shell.say 'Povoamento da base de dados concluído'
