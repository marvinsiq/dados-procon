class Ranking
  include Mongoid::Document

  belongs_to :pessoa_juridica
  
  field :reclamacoes_total, :type => Integer
  field :reclamacoes_2009, :type => Integer
  field :reclamacoes_2010, :type => Integer
  field :reclamacoes_2011, :type => Integer
  field :posicao_geral, :type => Integer
  field :posicao_2009, :type => Integer
  field :posicao_2010, :type => Integer
  field :posicao_2011, :type => Integer

end
