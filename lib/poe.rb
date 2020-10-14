require_relative 'common/support'

class Poe

  DEFAULT_PASSWORD = 'diman1234'.freeze

  attr_accessor :captcha_solution
  attr_reader :password

  def initialize(args, options = {})
    @login = args[:login]
    @email = args[:email]
    @password = options.fetch(:password, DEFAULT_PASSWORD)
  end

  def create
    button = form.button_with(value: 'Create Account')
    response = form.click_button(button)
    response_handler(response)
  end

  def confirm(account_verify_link)
    agent.get(account_verify_link)
  end

  def captcha_from_page
    page.search('.g-recaptcha').at('div').attributes['data-sitekey'].value
  end

  private

  attr_reader :email, :login

  def agent
    @agent ||= Mechanize.new
  end

  def configure_agent
    agent.follow_meta_refresh = true
    agent.user_agent_alias = 'Windows IE 11'
    agent.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end

  def page
    @page ||= agent.get(Support::POE_URL)
  end

  def form
    page.form_with(id: 'create_account') do |form|
      form['accountName'] = login
      form['email'] = email
      form['password'] = password
      form['passwordConfirmation'] = password
      form['tzOffset'] = -420
      form.checkbox_with(name: 'acceptTerms').check
      form['captcha'] = captcha_solution
    end
  end

  def response_handler(response)
    if response.parser.xpath('//li[contains(text(), "Too many")]').text == 'Too many accounts have registered with this ip address.'
      raise IpError, 'Ip was banned, change ip'
    end
    if response.parser.xpath('//li[contains(text(), "wrong")]').text == 'Captcha value is wrong'
      raise CaptchaWrongError, 'Captcha is wrong'
    end

    response
  end
end
