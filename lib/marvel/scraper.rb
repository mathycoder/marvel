require 'pry'

# Run this in IRB to test things out 
# require_relative './lib/marvel.rb'
# Scraper.new.plot_scraper 

class Scraper 
  attr_accessor :path 
  
  def initialize(path="https://en.wikipedia.org/wiki/List_of_Marvel_Cinematic_Universe_films")
    @path = path 
  end 
  
  def plot_scraper 
    html = open(@path)
    doc = Nokogiri::HTML(html)
    plots = [] 
    paragraphs = doc.css(".mw-parser-output p")
    paragraphs.shift() 
    paragraphs.shift()
    paragraphs.each_with_index do |paragraph, index|
      plots << paragraph.text if index % 3 == 0  
    end 
    plots.shift() 
    binding.pry 
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
    film_array
  end
  
    # def scrape_details_page 
  #   html = open("https://en.wikipedia.org/wiki/Iron_Man_(2008_film)")
  #   doc = Nokogiri::HTML(html)
    
  #   #works for https://en.wikipedia.org/wiki/The_Avengers_(2012_film)
    
    
  #   director = doc.css(".infobox.vevent tbody tr")[2].css("td").text
  #   producer = doc.css(".infobox.vevent tbody tr")[3].css("td").text
  #   screenplay = doc.css(".infobox.vevent tbody tr")[4].css("td").text
  #   story = doc.css(".infobox.vevent tbody tr")[5].css("td").text
    
  #   #starring doesn't work for Iron Man 
  #   starring = doc.css(".infobox.vevent tbody tr")[7].css("td").text
  #   runtime = doc.css(".infobox.vevent tbody tr")[14].css("td").text
  #   budget = doc.css(".infobox.vevent tbody tr")[17].css("td").text
  #   box_office = doc.css(".infobox.vevent tbody tr")[18].css("td").text
    
  # end 
end 