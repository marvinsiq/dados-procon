# encoding: utf-8
#
# Tarefa para automação do processo de tratamento de arquivos CSV. Mescla os dados
# de todos os arquivos CSV para uma entidade e gera um novo arquivo de dados no formato CSV.
#
# autor: Aureliano
# data: 19/12/2012

require 'csv'

namespace :data do

  resources = [
    'tmp/reclamacoes-fundamentadas-sindec-2009.csv',
    'tmp/reclamacoes-fundamentadas-sindec-2010.csv',
    'tmp/reclamacoes-fundamentadas-sindec-2011.csv'
  ]
  
  columns = [
    'anocalendario',
    'DataArquivamento',
    'DataAbertura',
    'regiao',
    'UF',
    'strRazaoSocial',
    'strNomeFantasia',
    'Tipo',
    'NumeroCNPJ',
    'DescCNAEPrincipal',
    'Atendida',
    'CodigoAssunto',
    'DescricaoAssunto',
    'SexoConsumidor',
    'FaixaEtariaConsumidor',
    'CEPConsumidor'
  ]
  
  desc 'Mescla todos osarquivos de dados (CSV) de uma entidade (após a execução os arquivos da pasta tmp são excluídos)'
  task :merge do
    data = []
    resources.each do |file|
      puts "Carregando arquivos de dados de '#{file}'"
      data.concat(load_data_from_csv(file, columns))      
    end
    
    write_file data, columns
    puts `rm -v tmp/*`
  end
  
  def write_file(data, columns)
    `mkdir db` unless File.exist? 'db'
    file = 'db/reclamacoes_fundamentadas_db.csv'
    puts "Escrevendo arquivo de dados #{file}"

    text = columns.join(';') + "\n"
    data.each {|line| text << line.join(';') + "\n" }
    
    # remove useless data
    text.gsub! /^;{2,}$/, ''
    text.gsub! /^\(\d+\srow\(s\)\saffected\);*/, ''
    text.gsub! /\n{3}/, "\n"
    
    File.open(file, 'w') {|f| f.write text }
  end
  
  def load_data_from_csv(file, columns)
    data = []
    text = File.read(file).force_encoding('iso-8859-1')
    csv = CSV.parse(text, :headers => true, :col_sep => ';', :quote_char => '"', :force_quotes => true)
    
    csv.each do |row|
      row_data = []
      columns.each do |column|
        row_data << if row[column]
          (row[column].match /[",]/) ? "\"#{row[column].gsub /"/, '""'}\"" : row[column]
        else
          nil
        end
      end

      data << row_data
    end

    data
  end
  
end
