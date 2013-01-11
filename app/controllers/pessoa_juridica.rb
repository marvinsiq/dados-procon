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
    @chart_data = complaints_by_year_chart_data @pessoa_juridica
    
    render 'pessoa_juridica/complaints'
  end
  
  get :complaints_conclusion, :map => '/pessoajuridica/:id/reclamacoes/conclusao' do
    @pessoa_juridica = PessoaJuridica.where('_id' => params[:id]).first
    redirect '/404' unless @pessoa_juridica
    @chart_data = complaints_by_conclusion_chart_data @pessoa_juridica
  
    render 'pessoa_juridica/complaints_conclusion'
  end
  
  get :complaints_problem_type, :map => '/pessoajuridica/:id/reclamacoes/problemas' do
    @pessoa_juridica = PessoaJuridica.where('_id' => params[:id]).first
    redirect '/404' unless @pessoa_juridica
    compound = complaints_by_problems_chart_data @pessoa_juridica, params[:problema]
    @chart_data = compound[:data]
    @chart_empty = compound[:empty]
  
    render 'pessoa_juridica/complaints_problem_type'
  end
  
end
