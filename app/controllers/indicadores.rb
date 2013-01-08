DadosProcon.controllers :indicadores do
  
  get :ranking, :map => '/indicadores/ranking' do
    @ranking, @total = ranking_geral
    render 'indicadores/ranking'
  end
  
  get :ranking_by_year, :map => '/indicadores/ranking/:year' do
    year = params[:year].to_i
    @ranking, @total = ranking_by_year year
    render "indicadores/ranking_#{year}"
  end

end
