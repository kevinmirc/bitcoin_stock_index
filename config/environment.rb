require 'yaml'
require 'pry'
require 'rest-client'
require 'json'
require_relative '../app/runners/cli'
require_relative '../lib/data'
require_relative '../lib/scraper'

c=CLI.new
c.run
