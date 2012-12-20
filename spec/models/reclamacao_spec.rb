require 'spec_helper'

describe "Entidade Reclamacao" do

  let(:reclamacao) { Reclamacao.new }
  it 'pode ser instanciada' do
    reclamacao.should_not be_nil
  end
  
end
