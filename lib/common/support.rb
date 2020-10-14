module Support
  POE_URL = 'https://www.pathofexile.com/account/create'.freeze

  def net_get(val)
    Net::HTTP.get(val)
  end

  def uri_parse(val)
    URI.parse(val)
  end

  def json_parse(val)
    JSON.parse(val)
  end

  def extract(val)
    URI.extract(val)
  end
end
