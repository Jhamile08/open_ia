# class EmailJob < ApplicationJob
#   queue_as :default

#   def perform(form_table_id, description, email)
#     response = FormService.new(user_message: description).form_question
#     response_new = Response.create(form_table_id: form_table.id, ai_response: response[:data], status: "confirmado")
#     puts response_new.inspect
#     puts "esta es la respuesta"
#     puts response



#     if response[:success]
#       flash[:notice] = "Response received successfully!"
#     else
#       flash[:alert] = "Error: #{response[:error]}"
#     end
#   end
# end
