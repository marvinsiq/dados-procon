# encoding: utf-8

DadosProcon.helpers do

  def pessoa_juridica_name(pessoa_juridica)
    return '' if pessoa_juridica.nil?
    (pessoa_juridica.nome_fantasia.nil? || pessoa_juridica.nome_fantasia == 'NULL') ? pessoa_juridica.razao_social : pessoa_juridica.nome_fantasia
  end
  
  def prepare_ranking(pessoa_juridica)
    ranking = pessoa_juridica.ranking ||= Ranking.new
    ranking.reclamacoes_total ||= 0
    ranking.reclamacoes_2009 ||= 0
    ranking.reclamacoes_2010 ||= 0
    ranking.reclamacoes_2011 ||= 0
    
    ranking
  end
  
  def format_position(position)
    return 'Sem ranking' if position.nil? || position == 0
    "#{position} &#186;"
  end
  
  def complaints_by_year_chart_data(pessoa_juridica)
    ranking = prepare_ranking pessoa_juridica
    [
      ['Ano', 'Reclamações'], # header
      ['2009', ranking.reclamacoes_2009],
      ['2010', ranking.reclamacoes_2010],
      ['2011', ranking.reclamacoes_2011]
    ]
  end
  
  def complaints_by_conclusion_chart_data(pessoa_juridica)
    data = {}
    (2009..2011).each do |ano|
      reclamacoes = Reclamacao.where(:pessoa_juridica_id => pessoa_juridica.id, :ano_calendario => ano).only(:atendida)
      s = n = 0
      
      reclamacoes.each do |r|
        if r.atendida == 'S'
          s += 1
        else
          n += 1
        end
      end
      data[ano] = {:atendidas => s, :nao_atendidas => n}
    end
    
    [
      ['Ano', 'Reclamações atendidas', 'Reclamações não atendidas'],
      ['2011', data[2011][:atendidas], data[2011][:nao_atendidas]],
      ['2010', data[2010][:atendidas], data[2010][:nao_atendidas]],
      ['2009', data[2009][:atendidas], data[2009][:nao_atendidas]]
    ]
  end
  
  def complaints_by_problems_chart_data(pessoa_juridica, codigo_problema)
    empty = true
    data = {}
    (2009..2011).each do |ano|
      reclamacoes = Reclamacao.where(:pessoa_juridica_id => pessoa_juridica.id, :ano_calendario => ano, :codigo_problema => codigo_problema).only(:_id)
      data[ano] = reclamacoes.size
      empty = (reclamacoes.size == 0 && empty)
    end
    
    {:data => [
      ['Ano', 'Reclamações'],
      ['2011', data[2011]],
      ['2010', data[2010]],
      ['2009', data[2009]]
    ], :empty => empty}
  end
  
end
