class CaptchaWrongError < StandardError

  attr_reader :message
  def initialize(message)
    @message = message
  end
end

class IpError < StandardError

  def initialize(message)
    @message = message
  end
end
