DadosProcon.helpers do

  def pessoa_juridica_name(pessoa_juridica)
    return '' if pessoa_juridica.nil?
    (pessoa_juridica.nome_fantasia.nil? || pessoa_juridica.nome_fantasia == 'NULL') ? pessoa_juridica.razao_social : pessoa_juridica.nome_fantasia
  end  
end
