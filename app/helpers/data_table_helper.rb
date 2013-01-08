# encoding: utf-8

DadosProcon.helpers do

  def ranking_data_table(options)
    options[:page] ||= pagination_page_index
    data_page = DataPage.new(options)
    return "<i>Ranking vazio.</i>" if data_page.data.empty?
    
    position_method = (options[:year]) ? "posicao_#{options[:year]}" : 'posicao_geral'
    total_complaints = (options[:year]) ? "reclamacoes_#{options[:year]}" : 'reclamacoes_total'
    
    t = "<table name=\"ranking\" class=\"table table-striped\">"
    t << "<thead>"
    t << "\n  <tr>\n    <th>Posição</th>\n    <th>Pessoa Jurídica</th>\n    <th>Reclamações</th>\n  </tr>"
    t << "</thead>"
    
    t << "\n<tboby>"
    data_page.data.each do |ranking|
      t << "\n  <tr>\n    <td>#{format_position ranking.send(position_method)}</td>"
      t << "\n    <td>#{pessoa_juridica_name ranking.pessoa_juridica}</td>"
      t << "\n    <td>#{ranking.send(total_complaints)}</td>"
      t << "\n    <td><a href=\"/pessoajuridica/#{ranking.pessoa_juridica.id}\" class=\"btn btn-primary btn-small\">Detalhar</a></td>"
      t << "\n  </tr>"
    end
    
    t << "\n</tbody>"
    t << "\n</table>"
    t << pagination_layer(data_page)
    
    t << "\n<hr/><div>Total de pessoas jurídicas: #{data_page.total}</div>"
  end

end
