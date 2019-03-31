require 'pry'

class Scraper 
  attr_accessor :path, :doc 
  
  def initialize(path="https://en.wikipedia.org/wiki/List_of_Marvel_Cinematic_Universe_films")
    @path = path 
    html = open(@path)
    @doc = Nokogiri::HTML(html)
  end 
  
  def plot_scraper 
    plots = [] 
    paragraphs = @doc.css(".mw-parser-output p")
    paragraphs.shift()
    paragraphs.shift()
    paragraphs.each_with_index do |paragraph, index|
      if index > 0 && index <= 21*3 
        plots << {:plot => paragraph.text.split("[")[0]} if index % 3 == 0 
      end 
    end 
    plots 
  end 
  
  def box_office_table_scraper
    attributes = [] 
    
    @doc.css(".wikitable.sortable tr").each_with_index do |budget, index|
      if index >=2 && index <=22 
        attributes << {
          :budget => budget.css("td")[7].text.split("\n")[0],
          :worldwide_gross =>  budget.css("td")[4].text.split("\n")[0],
          :us_canada_gross => budget.css("td")[2].text.split("\n")[0],
          :link => "https://en.wikipedia.org" + budget.css("td")[0].css("a").attribute("href").value.split("#")[0]
        }
      end 
    end 
  attributes
  end 
  
  def rotten_tomatoes_scraper 
    attributes = [] 
    rows = @doc.css(".wikitable.sortable")[1].css("tbody tr")
    rows.each_with_index do |row,index|
      if index > 0 && index <= 21  
        attributes << {:rating => row.css("td")[1].text.split(" ")[0]}
      end 
    end 
    attributes
  end 
  
  def scrape_index_page
    table_array = @doc.css(".wikitable.plainrowheaders tbody")
    
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
    
    producer = nil
    screenwriter = nil
      
    string_array.each_with_index do |row,index| 
      array = row.split("\n")
      
      #attempting to deal with row-span producer values 
      if array[9] !=nil 
        producer = array[9] 
      end 
      
      #attempting to deal with col-span screenwriter values 
      if array[7] !=nil 
        screenwriter = array[7].split("[")[0]
      else
        screenwriter = array[5].split("[")[0]
      end 
      
      film_array << {
        :film => array[1],
        :date => array[3].split("(")[0],
        :director => array[5].split("[")[0],
        :screenwriter => screenwriter,
        :producer => producer
      }.compact
    end 
    film_array
  end
end 