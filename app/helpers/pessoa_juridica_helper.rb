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
  
  def create_chart_data(ranking)
    case params[:chart_class]
      when 'PieChart' then format_chart_data_by_year(ranking)
      when nil then format_chart_data_by_year(ranking)
      else nil
    end
  end
  
  private
    def format_chart_data_by_year(ranking)
      [
        ['Ano', 'Reclamações'], # header
        ['2009', ranking.reclamacoes_2009],
        ['2010', ranking.reclamacoes_2010],
        ['2011', ranking.reclamacoes_2011]
      ]
    end
  
end
