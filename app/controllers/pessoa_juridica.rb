DadosProcon.controllers :pessoa_juridica do
  
  get :profile, :map => '/pessoajuridica/:id' do
    @pessoa_juridica = PessoaJuridica.where('_id' => params[:id]).first
    redirect '/404' unless @pessoa_juridica
    @ranking = prepare_ranking @pessoa_juridica
    
    @breadcrumbs = [:text => 'Not implemented yet', :link => '/']
    render 'pessoa_juridica/profile'
  end
  
end
