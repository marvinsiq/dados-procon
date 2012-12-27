# encoding: utf-8

require 'spec_helper'

describe "Entidade DataPage" do

  create_reclamacoes

  context 'criação de objeto' do
    
    let(:data_page) { DataPage.new }
    it 'pode ser instanciada sem argumentos' do
      data_page.should_not be_nil
    end
    
    let(:data_page) { DataPage.new :page_size => 10, :total => 50 }
    it 'pode ser instanciada com argumentos' do
      data_page.should_not be_nil
      data_page.page_size.should eq 10
      data_page.total.should eq 50
      data_page.current_page_block.should eq 1..5
      data_page.pages.should eq 5
    end
    
    it 'pode ser criada com o método de classe create' do
      data_page = DataPage.new(:page_size => 5, :total => 2, :data => Reclamacao.where(:ano_calendario => 2009))
      
      data_page.should_not be_nil
      data_page.data.should_not be_nil
      data_page.data.size.should eq 2
    end
  end
  
  context 'métodos de acesso a atributos de classe existem' do
    let(:data_page) { DataPage.new :page_size => 10, :total => 50 }
  
    before do
      data_page = DataPage.new :page_size => 10, :total => 50
    end
    
    it 'responde aos métodos de leitura' do
      data_page.should respond_to :total
      data_page.should respond_to :page_index
      data_page.should respond_to :page_size
      data_page.should respond_to :pages
      data_page.should respond_to :data
      data_page.should respond_to :current_page_block
    end
    
    it 'responde aos métodos de escrita' do
      data_page.should respond_to 'page_index='
      data_page.should respond_to 'data='
    end
    
    it 'não responde aos métodos de escrita' do
      data_page.should_not respond_to 'total='
      data_page.should_not respond_to 'page_size='
      data_page.should_not respond_to 'pages='
      data_page.should_not respond_to 'current_page_block='
    end
  end
  
end
