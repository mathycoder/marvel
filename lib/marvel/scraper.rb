require 'pry'

# Run this in IRB to test things out 
# require_relative './lib/marvel.rb'
# Scraper.new.budget_scraper 

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
    plots 
  end 
  
  def box_office_table_scraper
    html = open(@path)
    doc = Nokogiri::HTML(html)
    attributes = [] 
    
    doc.css(".wikitable.sortable tr").each_with_index do |budget, index|
      if index >=2 && index <=22 
        attributes << {
          :budget => budget.css("td")[7].text.split("\n")[0],
          :worldwide_gross =>  budget.css("td")[4].text.split("\n")[0],
          :us_canada_gross => budget.css("td")[2].text.split("\n")[0],
          :link => "https://en.wikipedia.org" + budget.css("td")[0].css("a").attribute("href").value.split("#")[0]
        }
      end 
    end 
    binding.pry
  attributes
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
    
    plots = plot_scraper
      
    string_array.each_with_index do |row,index| 
      array = row.split("\n")
      film_array << {
        :film => array[1],
        :date => array[3].split("(")[0],
        :director => array[5].split("[")[0],
        :screenwriter => (array[7].split("[")[0] if array[7]!=nil),
        :producer => array[9],
        :plot => plots[index].split("[")[0],
      }.compact
    end 
    film_array
  end
end 