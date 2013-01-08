# encoding: utf-8

require 'spec_helper'

describe "IndicadoresController" do

  create_ranking
  
  it "carrega página do ranking geral de reclamações" do
    get '/indicadores/ranking'
    last_response.body.should include '<title>Consumidor online: Ranking</title>'
    last_response.body.should include '<h3>Ranking Geral de Reclamações</h3>'
  end
  
  it "carrega página do ranking de 2009" do
    get '/indicadores/ranking/2009'
    last_response.body.should include '<title>Consumidor online: Ranking 2009</title>'
    last_response.body.should include '<h3>Ranking de Reclamações no ano de 2009</h3>'
  end
  
  it "carrega página do ranking de 2010" do
    get '/indicadores/ranking/2010'
    last_response.body.should include '<title>Consumidor online: Ranking 2010</title>'
    last_response.body.should include '<h3>Ranking de Reclamações no ano de 2010</h3>'
  end
  
  it "carrega página do ranking de 2011" do
    get '/indicadores/ranking/2011'
    last_response.body.should include '<title>Consumidor online: Ranking 2011</title>'
    last_response.body.should include '<h3>Ranking de Reclamações no ano de 2011</h3>'
  end
  
end
