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
    
    #Each index gets to a different phase's table

    string_array = []
    for i in [0,1,2] do 
      temp_string_array = [] 
      table_array[i].css("tr").each do |row|
        temp_string_array << row.text
      end 
      temp_string_array.shift()
      string_array << temp_string_array
    end 
    string_array = string_array.flatten 
    
    film_array = []  
      
    string_array.each do |row| 
      array = row.split("\n")
      film_array << {
        :film => array[1],
        :date => array[3].split("(")[0],
        :director => array[5].split("[")[0],
        :screenwriter => (array[7].split("[")[0] if array[7]!=nil),
        :producer => array[9]
      }.compact
    end 
    film_array.shift() 
    film_array
  end 
end 