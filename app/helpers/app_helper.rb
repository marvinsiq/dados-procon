# encoding: utf-8

DadosProcon.helpers do

  def send_email
    @message = Message.new :name => params[:name], :email => params[:email],
      :subject => params[:subject], :body => params[:message]
    
    if @message.valid? && PADRINO_ENV != 'test'
      deliver :contato, :email, @message
    end
    
    @message.valid?
  end

  def render_404_error
    html = "<html>\n<head>\n  <title>Página não encontrada</title>\n<head>\n<body>\n  "
    html << image_tag('chuck-norris.jpg', :alt => 'Chuck Norris')
    html << '  <p><b>Chuck Norris disse que a página que você procura não existe. E se ele disse é melhor você acreditar!</b>'
    html << '  <br/><br/><a href="/">Ir para página inicial</a>'
    html << "\n</body>\n</html>"
  end
  
  def format_cnpj(cnpj)
    return '' if cnpj.nil? || cnpj == 'NULL'
    "#{cnpj[0, 2]}.#{cnpj[2, 3]}.#{cnpj[5, 3]}/#{cnpj[8, 4]}-#{cnpj[12, 2]}"
  end
  
  def format_date(date)
    return '' if date.nil?
    tokens = date.split '-'
    "#{tokens[2]}/#{tokens[1]}/#{tokens[0]}"
  end
  
  def get_tags_without_stopwords(text)
    return [] if text.nil?
    tags = text.split(/\s/)
    tags.each {|tag| tag.downcase! }
    tags.delete_if {|t| STOPWORDS.include? t }
  end
  
  def format_get_param(get_param)
    (get_param.nil?) ? '' : get_param.gsub(/\+/, ' ')
  end
  
  def pagination_layer(data_page)
    t = "<div class=\"pagination\">"
    t << "\n <ul>"
    
    t << "\n <li#{data_page.has_previous_pagination_block? ? '' : ' class="disabled"'}><a href=\"#{data_page.has_previous_pagination_block? ? pagination_url(data_page.previous_block_page) : 'javascript: void(0)'}\">&lt;&lt;</a></li>"
    t << "\n <li#{data_page.has_previous_page? ? '' : ' class="disabled"'}><a href=\"#{data_page.has_previous_page? ? pagination_url(data_page.previous_page) : 'javascript: void(0)'}\">&lt;</a></li>"
    
    data_page.current_page_block.each do |page|
      t << "\n <li#{(data_page.page_index == page) ? ' class="disabled"' : ''}><a href=\"#{(data_page.page_index == page) ? 'javascript: void(0)' : pagination_url(page)}\">#{page}</a></li>"
    end
    
    t << "\n <li#{data_page.has_next_page? ? '' : ' class="disabled"'}><a href=\"#{data_page.has_next_page? ? pagination_url(data_page.next_page) : 'javascript: void(0)'}\">&gt;</a></li>"
    t << "\n <li#{data_page.has_next_pagination_block? ? '' : ' class="disabled"'}><a href=\"#{data_page.has_next_pagination_block? ? pagination_url(data_page.next_block_page) : 'javascript: void(0)'}\">&gt;&gt;</a></li>"
    
    t << "\n </ul>"
    t << "</div>"
  end
  
  def pagination_url(page_index)
    params[:search_params] ? "?search_params=#{params[:search_params].gsub(/\s/, '+')}&page=#{page_index}" : "?page=#{page_index}"
  end
  
  def pagination_page_index
    value = params[:page] ||= 1
    page = value.to_i
    page = 1 if page < 1
    
    page
  end
  
  def skip_value(limit=nil)
    limit ||= DataPage.default_page_size
    ((pagination_page_index - 1) * limit)
  end

end
