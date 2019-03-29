#This is the gem's environment file 

require 'bundler/setup'
Bundler.require(:default)

require 'open-uri'
require 'nokogiri'

require_relative "marvel/version"
require_relative "marvel/scraper"
require_relative "marvel/CLI"


