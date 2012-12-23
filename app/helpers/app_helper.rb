# encoding: utf-8

DadosProcon.helpers do

  def send_email
    @success = false
    @errors = []
    @errors << "O 'Nome' deve ter pelo menos 2 caracteres." if (params[:name].nil? || params[:name].size < 2)
    @errors << "O 'e-mail' deve ser válido." unless (params[:email] =~ /[\w\d\.]+@\w+\.\w+/)
    @errors << "O 'Assunto' deve ter pelo menos 3 caracteres." if (params[:subject].nil? || params[:subject].size < 3)
    @errors << "O 'Texto' deve ter pelo menos 5 caracteres." if (params[:message].nil? || params[:message].size < 5)
    
    if @errors.empty?
      email(
        :to => params[:email],
        :subject => params[:subject],
        :body => params[:message]
      )
      
      params[:name] = params[:email] = params[:subject] = params[:message] = nil
      @success = true
    end
  end

  def render_404_error
    html = "<html>\n<head>\n  <title>Página não encontrada</title>\n<head>\n<body>\n  "
    html << image_tag('chuck-norris.jpg', :alt => 'Chuck Norris')
    html << '  <p><b>Chuck Norris disse que a página que você procura não existe. E se ele disse é melhor você acreditar!</b>'
    html << '  <br/><br/><a href="/">Ir para página inicial</a>'
    html << "\n</body>\n</html>"
  end

end
