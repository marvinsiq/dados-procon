# encoding: utf-8

require 'spec_helper'

describe "PessoaJuridicaController" do

  it "carrega página de perfil da pessoa jurídica" do
    get "/pessoajuridica/#{PessoaJuridica.where(:cnpj => '99866532321227').first.id}"
    last_response.body.should include '<title>Consumidor online: Pessoa Jurídica</title>'
    last_response.body.should include '<h3>Banco Cem por cento</h3>'
  end

  it "carrega página de reclamações da pessoa jurídica" do
    get "/pessoajuridica/#{PessoaJuridica.where(:cnpj => '99866532321227').first.id}/reclamacoes"
    last_response.body.should include '<title>Consumidor online: Pessoa Jurídica - Reclamações</title>'
    last_response.body.should include '<h3>Banco Cem por cento - Reclamações</h3>'
  end
  
end
