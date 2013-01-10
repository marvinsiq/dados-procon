# encoding: utf-8
#
# Tarefa para automação do processo de extração de dados.
#
# autor: Aureliano
# data: 19/12/2012

namespace :data do

  resources = {
    2011 => 'http://portal.mj.gov.br/admin/services/DocumentManagement/FileDownload.EZTSvc.asp?DocumentID={C59BBDC1-1656-458F-B375-9344627509D6}&ServiceInstUID={7C3D5342-485C-4944-BA65-5EBCD81ADCD4}=ExternalLink',
    2010 => 'http://portal.mj.gov.br/admin/services/DocumentManagement/FileDownload.EZTSvc.asp?DocumentID={4672EB15-FF64-480F-A564-9406A3F55A9F}&ServiceInstUID={7C3D5342-485C-4944-BA65-5EBCD81ADCD4}=ExternalLink',
    2009 => 'http://portal.mj.gov.br/admin/services/DocumentManagement/FileDownload.EZTSvc.asp?DocumentID={4EE0FBBF-0C40-44AA-BC35-C720B9CE7509}&ServiceInstUID={7C3D5342-485C-4944-BA65-5EBCD81ADCD4}=ExternalLink'
  }
  
  desc 'Baixa arquivos de dados no sítio do Ministério da Justiça'
  task :extraction do
    files = []
    `mkdir tmp` unless File.exist? 'tmp'
    
    resources.each do |k, v|
      puts "Carregando arquivo de dado de '#{v}'"
      file = "tmp/reclamacoes_fundamentadas_db_#{k}.zip"
      `wget -O #{file} "#{v}"`
      
      puts "Extraindo arquivo ZIP '#{file}' na pasta 'tmp'\n"
      `unzip #{file} -d tmp`
      files << file
    end
    
    files.each {|f| puts `rm -v #{f}` }
  end
end
