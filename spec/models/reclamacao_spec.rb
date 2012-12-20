# encoding: utf-8

require 'spec_helper'

describe "Entidade Reclamacao" do
  
  context 'métodos de acesso a atributos de classe existem' do
    before do
      @reclamacao = Reclamacao.new
    end
    
    it 'responde aos métodos de leitura' do
      @reclamacao.should respond_to :id
      @reclamacao.should respond_to :data_arquivamento
      @reclamacao.should respond_to :data_abertura
      @reclamacao.should respond_to :regiao
      @reclamacao.should respond_to :uf
      @reclamacao.should respond_to :razao_social
      @reclamacao.should respond_to :nome_fantasia
      @reclamacao.should respond_to :tipo
      @reclamacao.should respond_to :cnpj
      @reclamacao.should respond_to :cnae_principal
      @reclamacao.should respond_to :atendida?
      @reclamacao.should respond_to :codigo_assunto
      @reclamacao.should respond_to :descricao_assunto
      @reclamacao.should respond_to :sexo_consumidor
      @reclamacao.should respond_to :faixa_etaria_consumidor
      @reclamacao.should respond_to :cep_consumidor
      @reclamacao.should respond_to :tags
    end
    
    it 'responde aos métodos de escrita' do
      @reclamacao.should respond_to 'id='
      @reclamacao.should respond_to 'data_arquivamento='
      @reclamacao.should respond_to 'data_abertura='
      @reclamacao.should respond_to 'regiao='
      @reclamacao.should respond_to 'uf='
      @reclamacao.should respond_to 'razao_social='
      @reclamacao.should respond_to 'nome_fantasia='
      @reclamacao.should respond_to 'tipo='
      @reclamacao.should respond_to 'cnpj='
      @reclamacao.should respond_to 'cnae_principal='
      @reclamacao.should respond_to 'atendida='
      @reclamacao.should respond_to 'codigo_assunto='
      @reclamacao.should respond_to 'descricao_assunto='
      @reclamacao.should respond_to 'sexo_consumidor='
      @reclamacao.should respond_to 'faixa_etaria_consumidor='
      @reclamacao.should respond_to 'cep_consumidor='
      @reclamacao.should respond_to 'tags='
    end
  end
  
end
