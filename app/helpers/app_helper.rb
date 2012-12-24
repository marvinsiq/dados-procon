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

end
