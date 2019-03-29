# Run this in IRB to test things out 
# require_relative './lib/marvel.rb'

 Scraper 
  attr_accessor :path 
  
  def initialize(path="https://en.wikipedia.org/wiki/List_of_Marvel_Cinematic_Universe_films")
    @path = path 
  end 
  
  def initial_scrape
    
  end 
  
end 