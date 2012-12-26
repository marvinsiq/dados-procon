class Reclamacao
  include Mongoid::Document
  
  belongs_to :pessoa_juridica

  field :ano_calendario, :type => Integer
  field :data_arquivamento, :type => Date
  field :data_abertura, :type => Date
  field :uf, :type => String
  field :tipo, :type => Integer
  field :atendida, :type => Boolean
  field :codigo_assunto, :type => Integer
  field :descricao_assunto, :type => String

end
