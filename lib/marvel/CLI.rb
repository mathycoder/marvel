class Marvel::CLI 
  
  def run 
    welcome
    phase_menu 
  end 
  
  def goodbye 
    puts %q( 
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
  end 
  
  def welcome  
    puts %q(
    
      ███╗   ███╗     ██████╗    ██╗   ██╗                
      ████╗ ████║    ██╔════╝    ██║   ██║                
      ██╔████╔██║    ██║         ██║   ██║                
      ██║╚██╔╝██║    ██║         ██║   ██║                
      ██║ ╚═╝ ██║    ╚██████╗    ╚██████╔╝                
      ╚═╝     ╚═╝     ╚═════╝     ╚═════╝                 
      )
    puts "Welcome to the Marvel Cinematic Universe! (MCU)"
  end 
  
  def phase_menu 
    input = nil 
    while input != "exit"
      puts "\n1. Phase 1\n2. Phase 2\n3. Phase 3\n4. Sort by Rating\n5. Sort by Worldwide Gross\n6. Sort by US/Canada Gross\n\nSelect an option or type 'exit':"
      input = gets.strip.downcase 
      case input 
      when "1", "2", "3"
        phase(input.to_i)
      when "4"
        sort_by(Marvel::Movie.sort_by("rating"), "rating")
      when "5"
        sort_by(Marvel::Movie.sort_by("worldwide_gross"), "worldwide_gross")
      when "6" 
        sort_by(Marvel::Movie.sort_by("us_canada_gross"), "us_canada_gross")
      when "exit"
        goodbye
      else 
        puts "Please enter a valid input" 
      end 
    end 
  end 
  
  def sort_by(sorted_movies,attribute)
    puts "\n------------ MCU Films sorted by #{attribute.gsub("_", " ")} ------------".red
    sorted_movies.each_with_index do |movie,index|
      puts "#{index+1}. #{movie.film} - #{movie.send(attribute)}"
    end 
    puts "-----------------------------------------------------------".red
    manage_input(sorted_movies)
  end 
  
  def phase(num) 
    puts "\n------------------ Phase #{num} -----------------".red
    
    if num == 1 
      a,b = 0,5 
    elsif num == 2 
      a,b = 6,11
    elsif num == 3 
      a,b = 12,20
    end 
    
    Marvel::Movie.all.each_with_index do |movie, index|
      if index >=a && index <=b 
        puts "#{index + 1}. #{movie.film} - #{movie.date}"
      end 
    end 
    puts " --------------------------------------------".red 
    manage_input(Marvel::Movie.all, a,b)
  end 
  
  def manage_input(movie_list, a=0, b=Marvel::Movie.all.length-1)
    puts "Select a film number or type 'back':"
    input = gets.strip.downcase
    if input.to_i != 0 && input.to_i >=a+1 && input.to_i <=b+1 
      film_details(movie_list[input.to_i-1])
    elsif input != 'back'
      puts "Enter a valid selection!"
    end 
  end 
  
  def film_details(movie)
    puts "\n----------------#{movie.film} - #{movie.date}-------------".blue
    puts "Directed by: #{movie.director}  Produced by: #{movie.producer}"
    puts "Written by: #{movie.screenwriter}"
    puts "\nUS/Canada Box Office: #{movie.us_canada_gross}   Worldwide: #{movie.worldwide_gross}"   
    puts "Budget: #{movie.budget}               Rotten Tomatoes: #{movie.rating}\n"
    puts "\n#{movie.plot}"
    puts "--------------------------------------------------------------------------------".blue
    puts "Press 'enter' to go back to the menus"
    gets
  end 
end 