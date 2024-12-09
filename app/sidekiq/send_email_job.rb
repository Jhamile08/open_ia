class SendEmailJob
  include Sidekiq::Job

  def perform(name, email, id_response, description)
    response = Response.find(id_response)
    response_update = FormService.new(user_message: description).form_question
    response_new = response.update(ai_response: response_update[:data], status: "confirmado")
    puts "este es el inspect de response new"
    puts response.inspect
    puts "esta es la respuesta"
    puts response.inspect

    if response_update[:success]
      puts "Response received successfully!"
      FormMailer.response_confirmed_email(email, name, response.ai_response).deliver_now

    else
      puts "malo"
      FormMailer.response_failled_email(email, name)
    end
  end
end
