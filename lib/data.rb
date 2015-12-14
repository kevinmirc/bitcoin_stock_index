class Intrinio
  attr_accessor :client, :uri, :keys

  def initialize(ticker)
    @keys = YAML.load_file('application.yml')
    @uri = "https://www.intrinio.com/api"
    @url = "/data_point?ticker=#{ticker}&item=close_price"
    usd = client_request(@url)["value"]
    mbtc = convert(usd)
    puts "#{ticker} is worth $#{usd.round(2)} USD or #{mbtc.round(2)} mBTC"
  end

  # MOVE FUNCTIONALITY IN INIT TO HERE WHEN ADDING NEW
  # def spot_price(ticker="AAPL")
  #   url = "/data_point?ticker=#{ticker}&item=close_price"
  #   data = client_request(url)["value"]
  #   puts "#{ticker.upcase} is worth $#{data.round(2)} USD or ____ mBTC"
  # end

  def convert(price)
    n = Scraper.new
    current_value_of_bitcoin = n.get_price
    value = (price/current_value_of_bitcoin)
  end

  private

  def client_request(url)
    full_url = uri + url
    data = RestClient::Resource.new(full_url, @keys['USERNAME'], @keys['PASSWORD'])
    data = JSON.parse(data.get)
  end
end
