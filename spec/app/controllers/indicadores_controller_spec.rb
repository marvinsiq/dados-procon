# encoding: utf-8

require 'spec_helper'

describe "IndicadoresController" do

  create_ranking
  
  it "carrega página do ranking geral de reclamações" do
    get '/indicadores/ranking'
    last_response.body.should include '<title>Consumidor online: Ranking</title>'
    last_response.body.should include '<h3>Ranking Geral de Reclamações</h3>'
  end
  
end
