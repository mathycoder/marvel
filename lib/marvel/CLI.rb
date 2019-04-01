class CLI 
  
  def run 
    scrape_phase_movies
    add_attributes_to_movies
    Movie.sort_by_rating
    logo 
    welcome
    phase_menu 
  end 
  
  def logo 
    logo_string = %q( 
      ──────────────▐█████───────
      ──────▄▄████████████▄──────
      ────▄██▀▀────▐███▐████▄────
      ──▄██▀───────███▌▐██─▀██▄──
      ─▐██────────▐███─▐██───██▌─
      ─██▌────────███▌─▐██───▐██─
      ▐██────────▐███──▐██────██▌
      ██▌────────███▌──▐██────▐██
      ██▌───────▐███───▐██────▐██
      ██▌───────███▌──▄─▀█────▐██
      ██▌──────▐████████▄─────▐██
      ██▌──────█████████▀─────▐██
      ▐██─────▐██▌────▀─▄█────██▌
      ─██▌────███─────▄███───▐██─
      ─▐██▄──▐██▌───────────▄██▌─
      ──▀███─███─────────▄▄███▀──
      ──────▐██▌─▀█████████▀▀────
      ──────███──────────────────
    ) 
    puts logo_string 

  end 
  
  def welcome 
    puts "Welcome to the Marvel Cinematic Universe! (MCU)"
    puts "" 
  end 
  
  def goodbye 
    puts "Back to reality!"
  end 
  
  def phase_menu 
    input = nil 
    while input != "exit"
      puts "1. Phase 1"
      puts "2. Phase 2"
      puts "3. Phase 3"
      puts "4. Sort by Rating"
      puts ""
      puts "Select an option or type 'exit':"
      input = gets.strip.downcase 
      if input == "1" || input == "2" || input == "3"
        phase(input.to_i)
      elsif input == "4"
        sort_by_rating(Movie.sort_by_rating)
      elsif input == "exit"
        goodbye
      else 
        puts "Please enter a valid Phase" 
      end 
    end 
  end 
  
  def sort_by_rating(sorted_movies)
    puts ""
    puts " ----------------------------------------------------------"
    sorted_movies.each_with_index do |movie,index|
      puts "#{index+1}. #{movie.film} - #{movie.rating}"
    end 
    puts "-----------------------------------------------------------"
    
    ## repeated code 
    puts "Select a film number or type 'back':"
    input = gets.strip.downcase
    if input.to_i != 0 && input.to_i <= sorted_movies.length  
      film_details(sorted_movies[input.to_i-1])
    elsif input != 'back'
      puts "Enter a valid selection!"
    end 
    puts ""
    ## repeated code 
  end 
  
  
  
  def phase(num) 
    puts ""
    puts " ------------------ Phase #{num} -----------------"
    
    if num == 1 
      a,b = 0,5 
    elsif num == 2 
      a,b = 6,11
    elsif num == 3 
      a,b = 12,20
    end 
    
    Movie.all.each_with_index do |movie, index|
      if index >=a && index <=b 
        puts "#{index + 1}. #{movie.film} - #{movie.date}"
      end 
    end 
    puts " --------------------------------------------"
    
    ## repeated code 
    puts "Select a film number or type 'back':"
    input = gets.strip.downcase
    if input.to_i != 0 && input.to_i >=a+1 && input.to_i <=b+1 
      film_details(Movie.all[input.to_i-1])
    elsif input != 'back'
      puts "Enter a valid selection!"
    end 
    puts ""
    ## repeated code 
  end 
  
  def film_details(movie)
    #movie = Movie.all[film_number-1]
    puts "----------------#{movie.film} - #{movie.date}-------------"
    puts "Directed by: #{movie.director}  Produced by: #{movie.producer}"
    puts "Written by: #{movie.screenwriter}"
    puts ""
    puts "US/Canada Box Office: #{movie.us_canada_gross}   Worldwide: #{movie.worldwide_gross}"   
    puts "Budget: #{movie.budget}               Rotten Tomatoes: #{movie.rating}"
    puts ""
    puts "#{movie.plot}"
    puts "--------------------------------------------------------------------------------"
    puts "Press 'enter' to go back to the menus"
    gets
  end 
  
  def scrape_phase_movies
    movie_hash = Scraper.new.scrape_index_page
    Movie.new_from_collection(movie_hash)
  end 
  
  def add_attributes_to_movies
    attributes_array = [Scraper.new.box_office_table_scraper, Scraper.new.plot_scraper, Scraper.new.rotten_tomatoes_scraper]
    
    attributes_array.each do |attributes|
      Movie.all.each_with_index do |movie, index|
        movie.add_new_attributes(attributes[index])
      end 
    end 
  end 
  
end 