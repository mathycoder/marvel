class Movie 
  attr_accessor :film, :date, :director, :screenwriter, :producer, :plot, :budget, :worldwide_gross, :us_canada_gross, :link 
  
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
  
  
end 