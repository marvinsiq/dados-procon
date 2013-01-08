# encoding: utf-8

PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

def app
  ##
  # You can handle all padrino applications using instead:
  #   Padrino.application
  DadosProcon.tap { |app|  }
end

def create_reclamacoes
  create_pessoas_juridicas
  Reclamacao.delete_all
  
  Reclamacao.create :ano_calendario => 2009, :uf => 'MG', :razao_social => 'Supermercado Ibituruna', :pessoa_juridica => PessoaJuridica.where(:cnpj => '55487963254120').first
  Reclamacao.create :ano_calendario => 2009, :uf => 'DF', :razao_social => 'Clínicas Barão', :pessoa_juridica => PessoaJuridica.where(:cnpj => '55487963254120').first
  Reclamacao.create :ano_calendario => 2010, :uf => 'MG', :razao_social => 'Banco Cem por cento', :pessoa_juridica => PessoaJuridica.where(:cnpj => '99866532321227').first
end

def create_pessoas_juridicas
  PessoaJuridica.delete_all
  PessoaJuridica.create :razao_social => 'Supermercado Ibituruna', :cnpj => '55487963254120', :tags => ['supermercado', 'ibituruna', '55487963254120']
  PessoaJuridica.create :razao_social => 'Banco Cem por cento', :cnpj => '99866532321227', :tags => ['banco', 'cem', 'cento', '99866532321227']
end

def create_ranking
  Ranking.delete_all
  Ranking.create :pessoa_juridica => PessoaJuridica.first, :posicao_geral => 1, :posicao_2009 => 3, :posicao_2010 => 2, :posicao_2011 => 1,
                 :reclamacoes_total => 20, :reclamacoes_2009 => 5, :reclamacoes_2010 => 6, :reclamacoes_2011 => 11
end
