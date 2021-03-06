require 'pry'

class Marvel::Scraper
  attr_accessor :path, :doc

  def initialize(path="https://en.wikipedia.org/wiki/List_of_Marvel_Cinematic_Universe_films")
    @path = path
    html = open(@path)
    @doc = Nokogiri::HTML(html)
  end

  def plot_scraper
    plots = []
    @doc.css(".mw-parser-output p")[2..].each_with_index do |paragraph, index|
      if index > 0 && index <= 22*3
        plots << {:plot => paragraph.text.split("[")[0]} if index % 3 == 0
      end
    end
    plots
  end

  def box_office_table_scraper
    attributes = []
    @doc.css(".wikitable.plainrowheaders.sortable tr").each_with_index do |budget, index|
      if index >=3 && index <=27 && index !=9 && index !=16
        attributes << {
          :budget => budget.css("td")[6].text.split("\n")[0],
          :worldwide_gross =>  budget.css("td")[3].text.split("\n")[0],
          :us_canada_gross => budget.css("td")[1].text.split("\n")[0],
          :link => "https://en.wikipedia.org" + budget.css("th")[0].css("a").attribute("href").value.split("#")[0]
        }
      end
    end
  attributes
  end

  def rotten_tomatoes_scraper
    attributes = []
    @doc.css(".wikitable.sortable")[1].css("tbody tr").each_with_index do |row,index|
      if index > 2 && index!=9 && index!=16 && index <= 27
        attributes << {:rating => row.css("td")[0].text.split(" ")[0]}
      end
    end
    attributes
  end

  def scrape_index_page
    film_array = []
    producer = nil
    @doc.css(".wikitable.plainrowheaders tr").each_with_index do |row, index|
      if !row.text.include?("Film") && index >= 0 && index < 25

        #fixes row- and col-span inconsistencies
        producer = row.css("td")[3].text.split("\n")[0] if row.css("td")[3] !=nil
        row.css("td")[2] !=nil ? i = 2 : i = 1
        screenwriter = row.css("td")[i].text.split("[")[0]

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
