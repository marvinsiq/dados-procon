# encoding: utf-8

require 'spec_helper'

describe "Entidade Message" do
  
  context 'criação do objeto' do
    let(:message) { Message.new }
    it 'pode ser criada sem parâmetros' do
      message.should_not be_nil
    end
    
    let(:message) {
      Message.new :name => 'Aureliano', :email => 'aureliano@teste.com.br',
                  :subject => 'Teste de especificação', :body => 'Alguma coisa'
    }
    it 'pode ser criada passando parâmetros ao construtor' do
      message.should_not be_nil
      message.name.should eq 'Aureliano'
      message.email.should eq 'aureliano@teste.com.br'
      message.subject.should eq 'Teste de especificação'
      message.body.should eq 'Alguma coisa'
    end
  end
  
  context 'validação da mensagem' do
   
    it 'validação deve passar' do
      message = Message.new :name => 'Aureliano', :email => 'aureliano@teste.com.br',
                  :subject => 'Teste de especificação', :body => 'Alguma coisa'
      message.valid?.should be_true
    end
    
    it 'validação deve falhar para nome' do
      message = Message.new :name => 'A', :email => 'aureliano@teste.com.br',
                  :subject => 'Teste de especificação', :body => 'Alguma coisa'
      message.valid?.should be_false
      message.errors.size.should eq 1
      message.errors.include?("O 'Nome' deve ter pelo menos 2 caracteres.").should be_true
    end
    
    it 'validação deve falhar para email' do
      message = Message.new :name => 'Aureliano', :email => 'aureliano.teste.com.br',
                  :subject => 'Teste de especificação', :body => 'Alguma coisa'
      message.valid?.should be_false
      message.errors.size.should eq 1
      message.errors.include?("O 'e-mail' deve ser válido.").should be_true
    end
    
    it 'validação deve falhar para assunto' do
      message = Message.new :name => 'Aureliano', :email => 'aureliano@teste.com.br',
                  :subject => 'ab', :body => 'Alguma coisa'
      message.valid?.should be_false
      message.errors.size.should eq 1
      message.errors.include?("O 'Assunto' deve ter pelo menos 3 caracteres.").should be_true
    end
    
    it 'validação deve falhar para corpo de mensagem' do
      message = Message.new :name => 'Aureliano', :email => 'aureliano@teste.com.br',
                  :subject => 'Teste de especificação', :body => 'abc'
      message.valid?.should be_false
      message.errors.size.should eq 1
      message.errors.include?("O 'Texto' deve ter pelo menos 5 caracteres.").should be_true
    end
    
    it 'validação deve falhar para todos os campos' do
      message = Message.new :name => nil, :email => 'aureliano@teste',
                  :subject => nil, :body => nil
      message.valid?.should be_false
      message.errors.size.should eq 4

      message.errors.include?("O 'Nome' deve ter pelo menos 2 caracteres.").should be_true
      message.errors.include?("O 'e-mail' deve ser válido.").should be_true
      message.errors.include?("O 'Assunto' deve ter pelo menos 3 caracteres.").should be_true
      message.errors.include?("O 'Texto' deve ter pelo menos 5 caracteres.").should be_true
    end
  end
  
  context 'formatação' do
    let(:message) {
      Message.new :name => 'Aureliano', :email => 'aureliano@teste.com.br',
                  :subject => 'Teste de especificação', :body => 'Alguma coisa'
    }
    it 'deve formatar mensagem de texto' do
      text = 'Consumidor online => dados Procon'
      text << "\n\nRemetente: Aureliano\ne-mail: aureliano@teste.com.br\n"
      text << "Assunto: Teste de especificação\nMensagem: Alguma coisa"
      
      message.format_message.should eq text
    end
  end
  
end
