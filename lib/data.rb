class Intrinio < CLI
  attr_accessor :client, :uri, :keys, :url, :ticker

  def initialize(ticker)
    @keys = YAML.load_file('application.yml')
    @uri = "https://www.intrinio.com/api"
    @endpoint = ""
    @ticker = ticker
    @url = ""
  end

  def endpoint
    @endpoint = self.uri + self.url
  end

  def convert(price)
    n = Scraper.new
    current_value_of_bitcoin = n.get_price
    value = (price/current_value_of_bitcoin)
  end

  def spot_price
    @url = "/data_point?ticker=#{self.ticker}&item=close_price"
    usd = client_request["value"]
    if data_valid?(usd)
      mbtc = convert(usd)
      puts "#{self.ticker} is worth $#{usd.round(2)} USD or #{mbtc.round(2)} mBTC"
    end
  end

  def revenue_2014
    @url = "/data_point?ticker=#{self.ticker}&item=totalrevenue"
    usd = client_request["value"]
    if data_valid?(usd)
      mbtc = convert(usd)
      puts "#{self.ticker} made $#{usd.round(2)} USD in 2014, which is #{mbtc.round(2)} mBTC" #change mBTC to BTC
    end
  end

  def self.no_method_error
    puts "ITS WORKING!!!!!!!!!!!!!!!!!!!"
  end

  private

  def data_valid?(usd)
    if usd.class == String
      puts "Data not available"
      return false
    else
      true
    end
  end

  def client_request
    data = RestClient::Resource.new(endpoint, @keys['USERNAME'], @keys['PASSWORD'])
    data = JSON.parse(data.get)
  end
end
