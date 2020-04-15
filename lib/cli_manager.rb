
class Gamerfluent::Cli_manager 
  def start
    introduction 
    get_game_data
    videogame_loop 
  end 

  def get_game_data
    Gamerfluent::API_parser.get_games 
  end 

  def videogame_loop
    loop do 
    menu 
    input = get_videogame_choice 
    break if input == "Exit"
    next if input == "invalid"
    display_game(input)
  end
end 

  def display_game
    puts user_input
  end 

  def get_videogame_choice
    input = gets.strip.downcase
    return input if input == "Exit"
      if !valid? 
        puts "Please try another selection."
        return "invalid"
    end 
    return input.to_i - 1 
  end

  def valid?(i)
    i.to_i.between?(1, Gamerfluent::VideoGame.all.length)
  end 

  def menu 
    display_games
    display_instructions 
  end 
  
  def introduction 
    puts "Welcome to Gamerfluent!"
  end 

  def display_games
    Gamerfluent::VideoGame.all.each_with_index do |g,i|
      puts "#{i+1}) #{g}"
  end 

  def display_instructions 
    puts "Please choose a game by number or type 'exit' to exit the program." 
  end 
end 
end 
