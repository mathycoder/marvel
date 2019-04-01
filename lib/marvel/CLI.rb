class CLI 
  
  def run 
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
      puts "\n1. Phase 1"
      puts "2. Phase 2"
      puts "3. Phase 3"
      puts "4. Sort by Rating"
      puts "5. Sort by Worldwide Gross"
      puts "6. Sort by US/Canada Gross"
      puts "\nSelect an option or type 'exit':"
      input = gets.strip.downcase 
      if input == "1" || input == "2" || input == "3"
        phase(input.to_i)
      elsif input == "4"
      ## could we make this less repetitive? 
      ## could use the send method to handle it using the string I'm passing in.
        sort_by(Movie.sort_by_rating, "rating")
      elsif input == "5"
        sort_by(Movie.sort_by_worldwide_gross, "worldwide_gross")
      elsif input == "6"
        sort_by(Movie.sort_by_us_canada_gross, "us_canada_gross")
      elsif input == "exit"
        goodbye
      else 
        puts "Please enter a valid Phase" 
      end 
    end 
  end 
  
  def sort_by(sorted_movies,attribute)
    puts ""
    puts "\n------------ MCU Films sorted by #{attribute.gsub("_", " ")} ------------"
    sorted_movies.each_with_index do |movie,index|
      puts "#{index+1}. #{movie.film} - #{movie.send(attribute)}"
    end 
    puts "-----------------------------------------------------------"
    
    ## repeated code 
    puts "Select a film number or type 'back':"
    input = gets.strip.downcase
    if input.to_i != 0 && input.to_i <= sorted_movies.length  
      film_details(sorted_movies[input.to_i-1])
    elsif input != 'back'
      puts "Enter a valid selection!\n"
    end 
    #puts ""
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
    #puts ""
    ## repeated code 
  end 
  
  def film_details(movie)
    puts "----------------#{movie.film} - #{movie.date}-------------"
    puts "Directed by: #{movie.director}  Produced by: #{movie.producer}"
    puts "Written by: #{movie.screenwriter}\n"
    puts "US/Canada Box Office: #{movie.us_canada_gross}   Worldwide: #{movie.worldwide_gross}"   
    puts "Budget: #{movie.budget}               Rotten Tomatoes: #{movie.rating}\n"
    puts "#{movie.plot}"
    puts "--------------------------------------------------------------------------------"
    puts "Press 'enter' to go back to the menus"
    gets
  end 
end 