# require_relative './lib/marvel.rb'
# CLI.new.phase1

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
      puts "1. Phase 1"
      puts "2. Phase 2"
      puts "3. Phase 3"
      puts ""
      puts "Select a Phase or type 'exit':"
      input = gets.strip.downcase 
      case input 
      when "1" || "phase 1"
        phase1 
      when "2" || "phase 2"
        puts "More info on Phase 2"
      when "3" || "phase 3"
        puts "More info on Phase 3"
      when "exit"
        goodbye 
      else 
        puts "Please enter a valid Phase"
      end 
    end 
  end 
  
  def phase1 
    scrape_phase_movies
    puts ""
    puts " ------------------ Phase 1 -----------------"
    
    Movie.all.each_with_index do |movie, index|
      puts "#{index + 1}. #{movie.film} - #{movie.date}"
    end 
  
    puts "Select a film number:"
    input = gets.strip.downcase 
  end 
  
  def scrape_phase_movies
    movie_hash = Scraper.new.scrape_index_page
    Movie.new_from_collection(movie_hash)
  end 
  
end 