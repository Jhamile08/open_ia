require "net/http"
require "uri"
require "json"

class FormService
  def initialize(user_message)
    @user_message = user_message
    @api_url = "https://api.openai.com/v1/chat/completions"
  end
  def form_question
    retries ||= 0
    uri = URI(@api_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == "https"

    body = {
      model: "gpt-4",  # Puedes cambiar el modelo a "gpt-3.5-turbo" si lo prefieres
      messages: [
        { role: "system", content: "You are a helpful assistant." },
        { role: "user", content: @user_message.to_s }  # Aquí el mensaje del usuario
      ],
      temperature: 0.7,
      max_tokens: 150
    }.to_json

    request = Net::HTTP::Post.new(uri.path, { "Content-Type" => "application/json", "Authorization" => "Bearer #{ENV['OPENAI_API_KEY']}" })

    request.body = body

    begin
      response = http.request(request)
      response_body = JSON.parse(response.body)
      puts "response del service"
      puts response.inspect
      if response.code.to_i == 200
        { success: true, data: response_body["choices"].first["message"]["content"] }
      else
        { success: false, error: response_body["error"] || "Unknown error" }
      end
    rescue StandardError => e
      if (retries += 1) <= 3
        retry
      else
        { success: false, error: "Error after 3 retries: #{e.message}" }
      end
    end
  end
end
