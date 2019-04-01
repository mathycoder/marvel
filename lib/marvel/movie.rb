class Movie 
  attr_accessor :film, :date, :director, :screenwriter, :producer, :plot, :budget, :worldwide_gross, :us_canada_gross, :rating, :link   
  
  @@all = [] 
  
  def self.all
    @@all
  end 
  
  def initialize(attributes)
    attributes.each do |key, value|
      self.send("#{key}=",value)
    end 
    @@all << self 
  end 
  
  def self.new_from_collection(movie_array)
    movie_array.each{|attributes|self.new(attributes)}
  end 
  
  def add_new_attributes(attributes)
    attributes.each do |key, value|
      self.send("#{key}=",value)
    end 
  end 
  
  def self.sort_by_rating 
    sorted = @@all.sort_by{ |movie| movie.rating }
    sorted = sorted.reverse 
  end 
  
  def self.sort_by_worldwide_gross
    sorted = @@all.sort_by{ |movie| movie.worldwide_gross.gsub(/\D/,'').to_i }
    sorted = sorted.reverse 
  end 
  
  def self.sort_by_us_canada_gross
    sorted = @@all.sort_by{ |movie| movie.us_canada_gross.gsub(/\D/,'').to_i }
    sorted = sorted.reverse 
  end 
    
end 