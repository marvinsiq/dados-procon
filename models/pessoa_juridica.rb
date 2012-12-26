class PessoaJuridica
  include Mongoid::Document
  
  has_many :reclamacaos

  field :razao_social, :type => String
  field :nome_fantasia, :type => String
  field :cnpj, :type => String
  field :cnae_principal, :type => String
  field :tags, :type => Array
  
  def self.with_tags(options)
    options[:skip] ||= 0
    options[:limit] ||= 0
    reclamacoes = []
    
    where(:tags => {'$all' => options[:tags]}).asc(:razao_social).skip(options[:skip]).limit(options[:limit]).each {|document| reclamacoes << document }
    reclamacoes
  end
    
  def self.count_with_tags(tags)
    where(:tags => {'$all' => tags}).count
  end
  
end
