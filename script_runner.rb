require_relative 'dependencies'

puts 'Accs count?'
acc_count = gets.to_i
puts 'What password do you want? default: diman1234'
password = gets.chomp
puts 'Key for https://anti-captcha.com/'
secret_key = gets.chomp

valid_accounts = 0

while valid_accounts < acc_count
  begin
    get_nada = GetNada.new(message_from: 'support@grindinggear.com')
    poe = Poe.new(email: get_nada.email, login: get_nada.address, options: { password: password })
    anticaptcha = AntiCaptchaResolver.new(token: secret_key, website_url: Support::POE_URL,
                                          website_key: poe.captcha_from_page)

    puts 'captcha resolving...30-60 sec'
    poe.captcha_solution = anticaptcha.resolve

    poe.create
    puts 'account created, waiting confirmation email...90-150sec'

    5.times do
      if get_nada.mail_empty?
        sleep 30
      else
        links = get_nada.extract_links
        poe.confirm(links.last)
        File.open('accs.txt', 'a+') { |f| f.write("#{get_nada.email};#{poe.password};#{get_nada.address}\n") }
        valid_accounts += 1
        puts 'done...'
        break
      end
    end
  rescue IpError, AntiCaptcha::Error => e
    puts e.message
    exit
  rescue CreationError, AntiCaptcha::Timeout => e
    puts e.message
  end
end
