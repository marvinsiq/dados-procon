DadosProcon.controllers :indicadores do
  
  get :ranking, :map => '/indicadores/ranking' do
    @ranking, @total = ranking_geral
    render 'indicadores/ranking'
  end

end
