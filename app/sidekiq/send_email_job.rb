class SendEmailJob
  include Sidekiq::Job

  def perform(name, email, id_response, description)
    response = Response.find(id_response)
    response_update = FormService.new(user_message: description).form_question
    response_new = response.update(ai_response: response_update[:data], status: "confirmado")
    puts "este es el inspect de response new"
    puts response_new.inspect
    puts "esta es la respuesta"
    puts response.inspect

    if response[:success]

      puts "Response received successfully!"

    else
      puts "malo"
    end
    puts "holi #{name}"
  end
end
