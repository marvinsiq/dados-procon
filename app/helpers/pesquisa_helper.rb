DadosProcon.helpers do
  
  def nil_to_text(text)
    if text.nil?
      ''
    else
      text == 'NULL' ? '' : text
    end
  end
end
