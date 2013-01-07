# encoding: utf-8

require 'spec_helper'

describe "Entidade Ranking" do

  context 'métodos de acesso a atributos de classe existem' do
    before do
      @ranking = Ranking.new
    end
    
    it 'responde aos métodos de leitura' do
      @ranking.should respond_to :id
      @ranking.should respond_to :pessoa_juridica
      @ranking.should respond_to :posicao_geral
      @ranking.should respond_to :posicao_2009
      @ranking.should respond_to :posicao_2010
      @ranking.should respond_to :posicao_2011
      @ranking.should respond_to :reclamacoes_total
      @ranking.should respond_to :reclamacoes_2009
      @ranking.should respond_to :reclamacoes_2010
      @ranking.should respond_to :reclamacoes_2011
    end
    
    it 'responde aos métodos de escrita' do
      @ranking.should respond_to 'id='
      @ranking.should respond_to 'pessoa_juridica='
      @ranking.should respond_to 'posicao_geral='
      @ranking.should respond_to 'posicao_2009='
      @ranking.should respond_to 'posicao_2010='
      @ranking.should respond_to 'posicao_2011='
      @ranking.should respond_to 'reclamacoes_total='
      @ranking.should respond_to 'reclamacoes_2009='
      @ranking.should respond_to 'reclamacoes_2010='
      @ranking.should respond_to 'reclamacoes_2011='
    end
  end
  
end
