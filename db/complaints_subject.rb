require 'yaml'

res = Reclamacao.all.distinct(:codigo_problema)

data = {}
res.each do |codigo|
  descricao = Reclamacao.where(:codigo_problema => codigo).only(:descricao_problema).limit(1).first.descricao_assunto
  data[codigo] = descricao
end

File.open('.complaint_subjects.yml', 'w') {|f| f.write data.to_yaml }
