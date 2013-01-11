DadosProcon.controllers :pesquisa do

  get :pessoa_juridica, :map => '/pesquisa/pessoajuridica' do
    render 'pesquisa/pessoa_juridica'
  end
  
  get :compara_pessoas_juridicas, :map => '/pesquisa/compara/pessoajuridica' do
    render 'pesquisa/compara_pessoas_juridicas'
  end
  
  get :painel_comparacao_pessoas_juridicas, :map => '/pessoajuridica/comparacao/:ids' do
    'TELA NAO IMPLEMENTADA'
  end

end
