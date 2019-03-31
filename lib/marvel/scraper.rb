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
    @doc.css(".mw-parser-output p")[2..].each_with_index do |paragraph, index|
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
    @doc.css(".wikitable.sortable")[1].css("tbody tr").each_with_index do |row,index|
      if index > 0 && index <= 21  
        attributes << {:rating => row.css("td")[1].text.split(" ")[0]}
      end 
    end 
    attributes
  end 
 
  def scrape_index_page
    film_array = [] 
    producer = nil 
    @doc.css(".wikitable.plainrowheaders tr").each_with_index do |row, index|
      if !row.text.include?("Film") && index >= 0 && index < 24 
        
        #attempting to deal with row-span producer values 
        if row.css("td")[3] !=nil 
          producer = row.css("td")[3].text.split("\n")[0] 
        end 
        
        #attempting to deal with col-span screenwriter values 
        if row.css("td")[2] !=nil 
          screenwriter = row.css("td")[2].text.split("[")[0]
        else
          screenwriter = row.css("td")[1].text.split("[")[0]
        end 
        
        film_array << {
        :film => row.css("th").text.split("\n")[0],
        :date => row.css("td")[0].text.split("(")[0],
        :director => row.css("td")[1].text.split("[")[0],
        :screenwriter => screenwriter,
        :producer => producer
        }
      end 
    end 
    film_array
  end 
  
end 