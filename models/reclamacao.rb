class Reclamacao
  include Mongoid::Document

  field :ano_calendario, :type => Integer
  field :data_arquivamento, :type => Date
  field :data_abertura, :type => Date
  field :regiao, :type => String
  field :uf, :type => String
  field :razao_social, :type => String
  field :nome_fantasia, :type => String
  field :tipo, :type => Integer
  field :cnpj, :type => String
  field :cnae_principal, :type => String
  field :atendida, :type => Boolean
  field :codigo_assunto, :type => Integer
  field :descricao_assunto, :type => String
  field :sexo_consumidor, :type => String
  field :faixa_etaria_consumidor, :type => String
  field :cep_consumidor, :type => String
  field :tags, :type => Array
  
end
