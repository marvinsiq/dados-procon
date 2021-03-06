# encoding: utf-8

require 'spec_helper'

describe "PesquisaController" do

  it "carrega página de consulta de pessoas jurídicas" do
    get '/pesquisa/pessoajuridica'
    last_response.body.should include '<title>Consumidor online: Pesquisa por Pessoa Jurídica</title>'
    last_response.body.should include '<h3>Pesquisa por Pessoa Jurídica</h3>'
    last_response.body.should include '<form method="get" id="form_consulta" class="form-search" action="/pesquisa/pessoajuridica" accept-charset="UTF-8">  <div class="input-append">'
  end
  
  it "carrega página de comparação de pessoas jurídicas" do
    get '/pesquisa/compara/pessoajuridica'
    last_response.body.should include '<title>Consumidor online: Comparar Pessoas Jurídicas</title>'
    last_response.body.should include '<h3>Comparar Pessoas Jurídicas</h3>'
    last_response.body.should include '<form method="get" id="form_consulta" class="form-search" action="/pesquisa/compara/pessoajuridica" accept-charset="UTF-8">  <div class="input-append">'
  end
  
end
