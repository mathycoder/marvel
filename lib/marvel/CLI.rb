class CLI 
  
  def run 
    welcome
    phase_menu 
    input = user_input
  end 
  
  def welcome 
    puts "Welcome to the Marvel Cinematic Universe! (MCU)"
    puts "" 
  end 
  
  def phase_menu 
    puts "1. Phase 1"
    puts "2. Phase 2"
    puts "3. Phase 3"
    puts ""
    puts "Select a Phase:"
  end 
  
  def user_input 
    gets.strip 
  end 
  
end 