
class Gamerfluent::Cli_manager 

  def initialize 
    @page = 0  
    @limit = 20 
  end 

  def start
    logo
    introduction 
    get_game_data(@page += 1)

    videogame_loop 
  end 

  def logo
    puts "

 ██████   █████  ███    ███ ███████ ██████  ███████ ██      ██    ██ ███████ ███    ██ ████████ 
 ██       ██   ██ ████  ████ ██      ██   ██ ██      ██      ██    ██ ██      ████   ██    ██    
 ██   ███ ███████ ██ ████ ██ █████   ██████  █████   ██      ██    ██ █████   ██ ██  ██    ██    
 ██    ██ ██   ██ ██  ██  ██ ██      ██   ██ ██      ██      ██    ██ ██      ██  ██ ██    ██    
  ██████  ██   ██ ██      ██ ███████ ██   ██ ██      ███████  ██████  ███████ ██   ████    ██  "
  end

  def get_game_data(page)
    Gamerfluent::API_parser.get_games(page)
  end 

  def videogame_loop
    loop do 
    menu 
    input = get_videogame_choice 
    case input 

    when "exit"
      break

    when "invalid"
      next 
    
    when "next"

    when "previous"

    else 
      display_game(input)
    end 
  end
end 

  def display_game(i)
    g = Gamerfluent::VideoGame.all[i]
    Gamerfluent::API_parser.get_more_game_info(g) if !g.informed?
    puts g.all_information   
    puts "\n\n"
    puts "Press any key to continue:"
    gets 
  end 

  def get_videogame_choice
    commands = ["exit", "next", "prev"]
    input = gets.strip.downcase
    return input.downcase if commands.include?(input.downcase)
      if !valid?(input)
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
    puts "\n\n\n\n"
    puts "Welcome to Gamerfluent!"
    puts "Learn more about games to decide what to play next!"
    sleep(1)
    puts "\n\n\n\n"
  end 

  def display_games
    start, stop = get_page_range
    puts "PAGE #{@page}"
    Gamerfluent::VideoGame.all[start...stop].each_with_index do |g, i|
      puts "#{i+1}) #{g}"
    end 
  end 

  def get_page_range
    return [(@page-1)* @limit]
  end 

  def display_instructions 
    puts "Please choose a game by number or type 'exit' to exit the program."
    puts "You may also type 'next' to see the next page of games.  #{"You may also type 'prev' to see the previous page of games." if @page > 1}"
  end 

end 
 
