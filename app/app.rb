class DadosProcon < Padrino::Application
  register Padrino::Rendering
  register Padrino::Helpers

  get :index do
    'HOME PAGE'
  end
  
  get :contato do
    render :contato
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

end
