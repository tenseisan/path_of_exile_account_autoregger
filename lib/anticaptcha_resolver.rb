class AntiCaptchaResolver

  CAPTCHA_READY = 'ready'.freeze

  def initialize(args)
    @website_key = args[:website_key]
    @website_url = args[:website_url]
    @token = args[:token]
  end

  def resolve
    solution = anticaptcha.decode_nocaptcha!(website_key: website_key, website_url: website_url)
    solution.g_recaptcha_response
  end

  private

  attr_reader :website_key, :website_url, :token

  def anticaptcha
    @anticaptcha ||= AntiCaptcha.new(token)
  end
end
