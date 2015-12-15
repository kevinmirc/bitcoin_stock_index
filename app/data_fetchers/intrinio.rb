class IntrinioAPI
  attr_accessor :data
  def initialize(endpoint)
    key = YAML.load_file('application.yml')
    @data = RestClient::Resource.new(endpoint, key['USERNAME'], key['PASSWORD'])
    @data = JSON.parse(data.get)
  end
end
