#### RANKING GERAL ####

map = %Q{
  function() {
    emit(this.pessoa_juridica_id, 1);
  }
}

reduce = %Q{
  function (key, values) {
    var sum = 0;
    values.forEach(function (doc) {
      sum += doc;
    });
    
    return sum;
  }
}

Ranking.delete_all
res = Reclamacao.collection.map_reduce(map, reduce, :out => {:inline => 1}, :raw => true)
documents = {}
res['results'].each do |k, v|
  documents[k['_id']] = [{ :pessoa_juridica => k['_id'], :reclamacoes => k['value'] }]
end

#### RANKING POR ANOS ####

map = %Q{
  function() {
    emit({pessoa_juridica_id: this.pessoa_juridica_id, ano_calendario: this.ano_calendario}, 1);
  }
}

res = Reclamacao.collection.map_reduce(map, reduce, :out => {:inline => 1}, :raw => true)
res['results'].each do |k, v|
  pj = k['_id']['pessoa_juridica_id']
  if documents[pj]
    documents[pj] << { :ano_calendario => k['_id']['ano_calendario'], :reclamacoes => k['value'] }
  else
    documents[pj] = [{ :ano_calendario => k['_id']['ano_calendario'], :reclamacoes => k['value'] }]
  end  
end

rankings = []
documents.each do |k, v|
  r = Ranking.new :pessoa_juridica_id => k
  
  v.each do |data|
    if data[:ano_calendario]
      r.send("reclamacoes_#{data[:ano_calendario].to_i}=", data[:reclamacoes])
    else
      r.reclamacoes_total = data[:reclamacoes]
    end
  end
  
  rankings << r
end

(2009..2011).each do |year|
  rankings.sort! do |x, y|
    first = x.send("reclamacoes_#{year}")
    second = y.send("reclamacoes_#{year}")
    first ||= 0
    second ||= 0
    second <=> first
  end
  
  pos = 0
  score = 0
  rankings.each do |r|
    this_score = r.send("reclamacoes_#{year}")
    next unless this_score
    
    unless this_score == score
      pos += 1
      score = this_score
    end
    
    r.send("posicao_#{year}=", pos)
  end
end

rankings.sort! {|x, y| y.reclamacoes_total <=> x.reclamacoes_total }
pos = 0
score = 0
data = []
count = 0

rankings.each do |r|
  this_score = r.reclamacoes_total
  
  unless r.reclamacoes_total == score
    pos += 1
    score = r.reclamacoes_total
  end
  
  r.posicao_geral = pos
  
  data << { :pessoa_juridica_id => r.pessoa_juridica_id, :reclamacoes_total => r.reclamacoes_total, :reclamacoes_2009 => r.reclamacoes_2009,
            :reclamacoes_2010 => r.reclamacoes_2010, :reclamacoes_2011 => r.reclamacoes_2011, :posicao_geral => r.posicao_geral,
            :posicao_2009 => r.posicao_2009, :posicao_2010 => r.posicao_2010, :posicao_2011 => r.posicao_2011 }

  count += 1
  if count == BUCKET_SIZE
    Ranking.collection.insert data
    data.clear
    count = 0
  end
end

Ranking.collection.insert data # insere o resto

documents = nil
rankings = nil

GC.start
