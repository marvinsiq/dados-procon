DadosProcon.helpers do

  def pessoa_juridica_name(pessoa_juridica)
    return '' if pessoa_juridica.nil?
    (pessoa_juridica.nome_fantasia.nil? || pessoa_juridica.nome_fantasia == 'NULL') ? pessoa_juridica.razao_social : pessoa_juridica.nome_fantasia
  end
  
  def prepare_ranking(pessoa_juridica)
    ranking = pessoa_juridica.ranking ||= Ranking.new
    ranking.reclamacoes_total ||= 0
    ranking.reclamacoes_2009 ||= 0
    ranking.reclamacoes_2010 ||= 0
    ranking.reclamacoes_2011 ||= 0
    
    ranking
  end
  
  def format_position(position)
    return 'Sem ranking' if position.nil? || position == 0
    "#{position} &#186;"
  end
end
