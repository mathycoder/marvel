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
  end 
  
  def goodbye 
    puts "Back to reality!"
  end 
  
  def phase_menu 
    input = nil 
    while input != "exit"
      puts "\n1. Phase 1\n2. Phase 2\n3. Phase 3\n4. Sort by Rating\n5. Sort by Worldwide Gross\n6. Sort by US/Canada Gross"
      puts "\nSelect an option or type 'exit':"
      input = gets.strip.downcase 
      case input 
      when "1", "2", "3"
        phase(input.to_i)
      when "4"
        sort_by(Movie.sort_by_rating, "rating")
      when "5"
        sort_by(Movie.sort_by_worldwide_gross, "worldwide_gross")
      when "6" 
        sort_by(Movie.sort_by_us_canada_gross, "us_canada_gross")
      when "exit"
        goodbye
      else 
        puts "Please enter a valid input" 
      end 
    end 
  end 
  
  def sort_by(sorted_movies,attribute)
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
    ## repeated code 
  end 
  
  def phase(num) 
    puts "\n------------------ Phase #{num} -----------------"
    
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