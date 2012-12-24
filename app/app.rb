class DadosProcon < Padrino::Application
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers

  get :index do
    render :index
  end
  
  get :contato do
    render :contato
  end
  
  post '/send_email' do
    if send_email
      redirect '/contato?msg_sent=true'
    else
      render :contato
    end
  end
  
  get :mapa do
    render :mapa
  end
  
  get :sobre do
    render 'ajuda/sobre'
  end
  
  error 404 do
    redirect '/pagina-nao-encontrada'
  end
  
  get '/pagina-nao-encontrada' do
    render_404_error
  end
  
  # Configure smtp mailer
  set :delivery_method, :smtp => { 
    :address              => ENV['EMAIL_SMTP_ADDRESS'],
    :port                 => 587,
    :user_name            => ENV['EMAIL_USER_NAME'],
    :password             => ENV['EMAIL_PASSWORD'],
    :authentication       => :plain,
    :enable_starttls_auto => true
  }

end
