require_relative 'common/mailer'

class GetNada < Mailer

  DOMAINS = %w[getnada.com zetmail.com dropjar.com]
  BOX_LINK = 'https://getnada.com/api/v1/inboxes/'
  MESSAGE_LINK = 'https://getnada.com/api/v1/messages/'

  attr_reader :domains

  def initialize(options = {})
    super
    @domains = options.fetch(:domains, DOMAINS)
  end

  def email
    @email ||= address + '@' + domains.sample
  end

  def extract_links
    extract(read_mail_with_uid)
  end

  def mail_empty?
    return true unless find_msg

    false
  end

  private

  def parse_inbox
    uri_parse(BOX_LINK + email)
  end

  def inbox_msgs
    unparsed_msgs = net_get(parse_inbox)
    inbox = json_parse(unparsed_msgs)
    inbox['msgs']
  end

  def find_msg
    inbox_msgs.find { |msg| msg['fe'] == message_from }
  end

  def msg_uid
    find_msg['uid']
  end

  def read_mail_with_uid
    url = uri_parse(MESSAGE_LINK + msg_uid)
    unparsed_mail = net_get(url)
    mail_data = json_parse(unparsed_mail)
    mail_data['html']
  end
end
