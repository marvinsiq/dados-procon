# encoding: utf-8

DadosProcon.helpers do

  def search_data_list
    data_list_template 'search'
  end
  
  def comparation_data_list
    data_list_template 'comparation'
  end
  
  private
    def data_list_template(action)
      limit = DataPage.default_page_size
      skip = skip_value # from app_helper
      
      tags = get_tags_without_stopwords params[:search_params]
      data_page = DataPage.new(:page_size => limit, :page => pagination_page_index, :total => PessoaJuridica.count_with_tags(tags), :data => PessoaJuridica.with_tags(:tags => tags, :skip => skip, :limit => limit))
      return "<i>Nenhum resultado encontrado.</i>" if data_page.data.empty?
      
      d = "#{data_page.total} item(s) encontrado(s).\n<hr/>"
          
      data_page.data.each do |pessoa_juridica|
        d << "<div name=\"div_item_resultado_consulta\">"
        item_href_tag = case action
          when 'search' then "<a href=\"/pessoajuridica/#{pessoa_juridica.id}\">"
          when 'comparation' then "<a href=\"javascript:savePessoaJuridicaOnSession('#{pessoa_juridica.id}', '#{pessoa_juridica_name pessoa_juridica}');\">"
          else ''
        end
        d << "\n Razão Social: #{item_href_tag} #{pessoa_juridica.razao_social}</a><br/>"
        d << "\n Nome Fantasia: #{nil_to_text pessoa_juridica.nome_fantasia}"
        d << "\n</div>"
        d << "\n<br/><br/>\n"
      end
      
      d << pagination_layer(data_page)
    end
end
