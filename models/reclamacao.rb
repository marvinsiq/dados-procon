class Reclamacao
  include Mongoid::Document
  
  belongs_to :pessoa_juridica

  field :ano_calendario, :type => Integer
  field :data_arquivamento, :type => Date
  field :data_abertura, :type => Date
  field :uf, :type => String
  field :atendida, :type => String
  field :codigo_problema, :type => Integer
  field :descricao_problema, :type => String

end
