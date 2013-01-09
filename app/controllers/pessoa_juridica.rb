DadosProcon.controllers :pessoa_juridica do
  
  get :profile, :map => '/pessoajuridica/:id' do
    @pessoa_juridica = PessoaJuridica.where('_id' => params[:id]).first
    redirect '/404' unless @pessoa_juridica
    @ranking = prepare_ranking @pessoa_juridica
    
    render 'pessoa_juridica/profile'
  end
  
  get :complaints, :map => '/pessoajuridica/:id/reclamacoes' do
    @pessoa_juridica = PessoaJuridica.where('_id' => params[:id]).first
    redirect '/404' unless @pessoa_juridica
    @ranking = prepare_ranking @pessoa_juridica
    @chart_data = create_chart_data @ranking
    
    render 'pessoa_juridica/complaints'
  end
  
end
