class DadosProcon < Padrino::Application
  register Padrino::Rendering
  register Padrino::Helpers

  get :index do
    'HOME PAGE'
  end
  
  error 404 do
    redirect '/pagina-nao-encontrada'
  end
  
  get '/pagina-nao-encontrada' do
    render_404_error
  end

end
