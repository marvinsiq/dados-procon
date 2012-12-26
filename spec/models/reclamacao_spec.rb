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
      @reclamacao.should respond_to :uf
      @reclamacao.should respond_to :tipo
      @reclamacao.should respond_to :atendida?
      @reclamacao.should respond_to :codigo_assunto
      @reclamacao.should respond_to :descricao_assunto
      @reclamacao.should respond_to :pessoa_juridica
    end
    
    it 'responde aos métodos de escrita' do
      @reclamacao.should respond_to 'id='
      @reclamacao.should respond_to 'data_arquivamento='
      @reclamacao.should respond_to 'data_abertura='
      @reclamacao.should respond_to 'uf='
      @reclamacao.should respond_to 'tipo='
      @reclamacao.should respond_to 'atendida='
      @reclamacao.should respond_to 'codigo_assunto='
      @reclamacao.should respond_to 'descricao_assunto='
      @reclamacao.should respond_to 'pessoa_juridica='
    end
  end
  
  context 'consulta reclamações no banco' do
    it '' do
    
    end
  end
end
