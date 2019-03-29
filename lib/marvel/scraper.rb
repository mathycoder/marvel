require 'pry'

# Run this in IRB to test things out 
# require_relative './lib/marvel.rb'
# Scraper.new.initial_scrape

class Scraper 
  attr_accessor :path 
  
  def initialize(path="https://en.wikipedia.org/wiki/List_of_Marvel_Cinematic_Universe_films")
    @path = path 
  end 
  
  def initial_scrape
    html = open(@path)
    doc = Nokogiri::HTML(html)
    tables = doc.css(".wikitable.plainrowheaders tbody")
    table_array = []
    tables.each do |tbody|
      table_array << tbody 
    end 
    
    #table_array[0] = Phase 1 table 
    #table_array[1] = Phase 2 table 
    #table_array[2] = Phase 3 table 
    
    #Scraping the Phase 1 Table 
    table = table_array[0].css("tr")
    table.each do |movie_row|
      table_columns = movie_row.css("th")
      table_columns.each do |movie_col|
        binding.pry 
        
      end 
    end 
  end 
  
  
end 