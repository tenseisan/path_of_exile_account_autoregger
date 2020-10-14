require_relative 'support'

class Mailer

  include Support

  attr_reader :address, :message_from

  def initialize(options = {})
    @address = options.fetch(:address, SecureRandom.urlsafe_base64(7).downcase)
    @message_from = options.fetch(:message_from)
  end
end
