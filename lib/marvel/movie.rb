class Movie 
  attr_accessor :film, :date, :director, :screenwriter, :producer, :plot, :budget, :worldwide_gross, :us_canada_gross, :rating, :link   
  
  @@all = [] 
  
  def self.all
    if @@all == [] 
      self.scrape_phase_movies
      self.add_attributes_to_movies
    end 
    @@all 
  end 
  
  def initialize(attributes)
    attributes.each do |key, value|
      self.send("#{key}=",value)
    end 
    @@all << self 
  end 
  
    ## Both of these methods shouldn't live in CLI 
  def self.scrape_phase_movies
    movie_hash = Scraper.new.scrape_index_page
    Movie.new_from_collection(movie_hash)
  end 
  
  def self.add_attributes_to_movies
    attributes_array = [Scraper.new.box_office_table_scraper, Scraper.new.plot_scraper, Scraper.new.rotten_tomatoes_scraper]
    
    attributes_array.each do |attributes|
      Movie.all.each_with_index do |movie, index|
        movie.add_new_attributes(attributes[index])
      end 
    end 
  end 
  
  def self.new_from_collection(movie_array)
    movie_array.each{|attributes|self.new(attributes)}
  end 
  
  def add_new_attributes(attributes)
    attributes.each do |key, value|
      self.send("#{key}=",value)
    end 
  end 
  
  #we can use send here as well! make one method does all of them!
  #gsub can be used for the first one 
  def self.sort_by_rating 
    sorted = self.all.sort_by{ |movie| movie.rating.gsub(/\D/,'').to_i }
    sorted = sorted.reverse 
  end 
  
  def self.sort_by_worldwide_gross
    sorted = self.all.sort_by{ |movie| movie.worldwide_gross.gsub(/\D/,'').to_i }
    sorted = sorted.reverse 
  end 
  
  def self.sort_by_us_canada_gross
    sorted = self.all.sort_by{ |movie| movie.us_canada_gross.gsub(/\D/,'').to_i }
    sorted = sorted.reverse 
  end 
    
end 