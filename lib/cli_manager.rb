
class Gamerfluent::Cli_manager 

  def initialize 
    @page = 0  
  end 

  def start
    logo
    introduction 
    @page += 1 
    get_game_data(@page)
    videogame_loop 
  end 

  def logo
    puts "
    ██████   █████  ███    ███ ███████ ██████  ███████ ██      ██    ██ ███████ ███    ██ ████████ 
   ██       ██   ██ ████  ████ ██      ██   ██ ██      ██      ██    ██ ██      ████   ██    ██    
   ██   ███ ███████ ██ ████ ██ █████   ██████  █████   ██      ██    ██ █████   ██ ██  ██    ██    
   ██    ██ ██   ██ ██  ██  ██ ██      ██   ██ ██      ██      ██    ██ ██      ██  ██ ██    ██    
    ██████  ██   ██ ██      ██ ███████ ██   ██ ██      ███████  ██████  ███████ ██   ████    ██    
                                                                                                 "
  end 

  def introduction 
    puts "Welcome to Gamerfluent!"
    puts "Learn more about games to decide what to play next!"
    sleep(1)
    puts "\n\n\n\n"
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
        @page += 1
        _, stop = get_page_range
        if Gamerfluent::VideoGame.all.length < stop 
          get_game_data(@page)
        end 

      when "prev"
        if @page <= 1 
          puts "\n\n"
          puts "You are already on page 1."
          puts "\n\n"
        else 
          @page -= 1  
        end 
      else 
         display_game(input)
      end 
    end 
    end 
  
 

  def display_game(i)
    index = (@page-1) * 20 + i
    g = Gamerfluent::VideoGame.all[index]
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
    i.to_i.between?(1, 20)           
  end 

  def menu 
    display_games
    display_instructions 
  end 

  def display_games
    start, stop = get_page_range
    puts "PAGE #{@page}"
    puts "\n\n"
    Gamerfluent::VideoGame.all[start...stop].each.with_index(start) do |g, i|
      puts "#{i+1}) #{g}"
    end 
  end 

  def get_page_range
    return [(@page-1)*20, @page*20]
  end 

  def display_instructions 
    puts "\n\n\n\n"
    puts "Please choose a game by number or type 'exit' to exit the program."
    puts "\n\n"
    puts "You may also type 'next' to see the next page of games.  #{"You may also type 'prev' to see the previous page of games." if @page > 1}"
  end 

end 
  
 
