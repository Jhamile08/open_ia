class SendEmailJob
  include Sidekiq::Job

  def perform(name, email)
    # Do something
  end
end
