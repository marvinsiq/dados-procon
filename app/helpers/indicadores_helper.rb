DadosProcon.helpers do

  def ranking_geral
    limit = DataPage.default_page_size
    
    ranking = Ranking.find(:all).asc(:posicao_geral).skip(skip_value).limit(limit)
    total = Ranking.find(:all).count
    
    [ranking, total]
  end
  
  def ranking_by_year(year)
    limit = DataPage.default_page_size
    
    ranking = Ranking.where("reclamacoes_#{year}" => {:$exists => true}).asc("posicao_#{year}").skip(skip_value).limit(limit)
    total = Ranking.where("reclamacoes_#{year}" => {:$exists => true}).count
    
    [ranking, total]
  end
  
end
