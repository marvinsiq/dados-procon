DadosProcon.helpers do

  def ranking_geral
    limit = DataPage.default_page_size
    
    ranking = Ranking.find(:all).asc(:posicao_geral).skip(skip_value).limit(limit)
    total = Ranking.find(:all).count
    
    [ranking, total]
  end
  
end
