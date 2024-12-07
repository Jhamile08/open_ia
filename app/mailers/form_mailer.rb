class FormMailer < ApplicationMailer
  default from: "erlindr@hotmail.com"
  def response_confirmed_email(email, name, response)
      @name = name
      @response = response
    mail(
      to: email,
      subject: "Respuesta disponible"
    )
  end
  def response_falled_email(email, name)
      @name = name
    mail(
      to: email,
      subject: "Respuesta fallida"
    )
  end
end
