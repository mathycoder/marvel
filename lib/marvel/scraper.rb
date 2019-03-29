require 'pry'

# Run this in IRB to test things out 
# require_relative './lib/marvel.rb'
# Scraper.new.scrape_index_page

class Scraper 
  attr_accessor :path 
  
  def initialize(path="https://en.wikipedia.org/wiki/List_of_Marvel_Cinematic_Universe_films")
    @path = path 
  end 
  
  def scrape_index_page
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

    string_array = [] 
    
    table_array[0].css("tr").each do |row|
      string_array << row.text
    end 
    
    film_array = []  
      
    string_array.each do |row| 
      array = row.split("\n")
      film_array << {
        :film => array[1],
        :date => array[3],
        :director => array[5],
        :screenwriter => array[7],
        :producer => array[9]
      }
    end 
    film_array.shift() 
    film_array
  end 
end 