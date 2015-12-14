# require 'yaml'
# require 'open-uri'
# require 'pry'
# require 'rest-client'
# require 'json'


class Intrinio
  USERNAME = "67f266e881a827b3411379d3da2f5daf"
  PASSWORD = "54e89d4aeda38d02a77fc442f97a5a77"
  attr_accessor :client, :uri

  def initialize
    @uri = "https://www.intrinio.com/api"
    # auth = get_auth
    @client = RestClient::Resource.new(uri, USERNAME, PASSWORD)
  end

  def spot_price(ticker="AAPL")
    url = "/data_point?ticker=#{ticker}&item=close_price"
    data = client_request(url)["value"]
    puts "#{ticker.upcase} is worth $#{data.round(2)} USD or ____ mBTC"
  end

  def convert

  end

  private

  def client_request(url)
    full_url = uri + url
    data = RestClient::Resource.new(full_url, USERNAME, PASSWORD)
    data = JSON.parse(data.get)
    # RestClient.get(full_url)
  end
end
