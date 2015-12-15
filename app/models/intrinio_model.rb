class Intrinio < CLI
  attr_accessor :client, :uri, :url, :ticker
  def initialize(ticker)
    @uri = "https://www.intrinio.com/api"
    @endpoint = ""
    @ticker = ticker
    @url = ""
  end

  def endpoint
    @endpoint = self.uri + self.url
  end

  def convert_to_mbtc(price)
    n = Scraper.new
    current_value_of_bitcoin = n.get_price_mbtc
    value = (price/current_value_of_bitcoin)
  end

  def convert_to_btc(price)
    n = Scraper.new
    current_value_of_bitcoin = n.get_price_btc
    value = (price/current_value_of_bitcoin)
  end

  def spot_price
    @url = "/data_point?ticker=#{self.ticker}&item=close_price"
    usd = IntrinioAPI.new(endpoint).data["value"]
    if data_valid?(usd)
      mbtc = convert_to_mbtc(usd)
      puts "#{self.ticker} is worth $#{usd.round(2)} USD or #{mbtc.round(2)} mBTC"
    end
  end

  def revenue_2014
    @url = "/data_point?ticker=#{self.ticker}&item=totalrevenue"
    usd = IntrinioAPI.new(endpoint).data["value"]
    if data_valid?(usd)

      btc = convert_to_btc(usd)
      formated_btc = format_num(btc)
      formated_usd = format_num(usd)
      puts "#{self.ticker} made $#{usd.round(2)} USD in 2014, which is #{btc.round(2)} BTC" #change mBTC to BTC
    end
  end

  private

  def format_num(num)
    # num = num.round
    # num = num.to_s.split("")
    # new_a = []
    # num.each.with_index(1) do |n, i|
    #   if i%4==0
    #     n = n + ","
    #   end
    #   new_a << n
    # end
    # new_a.join.chop
    # binding.pry
  end

  def data_valid?(usd)
    if usd.class == String
      puts "Data not available"
      return false
    else
      true
    end
  end
end
