# encoding: utf-8

require 'spec_helper'

describe "Entidade PessoaJuridica" do

  create_pessoas_juridicas

  context 'métodos de acesso a atributos de classe existem' do
    before do
      @pj = PessoaJuridica.new
    end
    
    it 'responde aos métodos de leitura' do
      @pj.should respond_to :id
      @pj.should respond_to :razao_social
      @pj.should respond_to :nome_fantasia
      @pj.should respond_to :cnae_principal
      @pj.should respond_to :cnpj
      @pj.should respond_to :reclamacaos
      @pj.should respond_to :ranking
      @pj.should respond_to :tags
    end
    
    it 'responde aos métodos de escrita' do
      @pj.should respond_to 'id='
      @pj.should respond_to 'razao_social='
      @pj.should respond_to 'nome_fantasia='
      @pj.should respond_to 'cnae_principal='
      @pj.should respond_to 'cnpj='
      @pj.should respond_to 'reclamacaos='
      @pj.should respond_to 'ranking='
      @pj.should respond_to 'tags='
    end
  end
  
  context 'consulta pessoas jurídicas no banco' do
    it 'conta número de pessoas jurídicas retornadas pela consulta' do
      PessoaJuridica.count_with_tags(['99866532321227']).should eq 1
    end
  
    it 'carrega pessoa jurídica com por CNPJ' do
      result = PessoaJuridica.with_tags(:tags => ['99866532321227'])
      result.size.should eq 1
      result.first.cnpj.should eq '99866532321227'
    end
  end
end
