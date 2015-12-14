class Scraper
  def get_page
    JSON.parse(RestClient.get("http://api.coindesk.com/v1/bpi/currentprice/allcurrencies.json?showex=1&calc=1"))
  end

  def get_price
    spot_price = self.get_page["bpi"]["USD"]["rate"].to_f
    millibit_spot = (spot_price * 0.001)
  end
end
