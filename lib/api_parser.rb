require 'net/http'
require 'open-uri'
require 'json'
 
class API_parser
 
  URL = "https://api.rawg.io/api/games/id"
 
  def get_games
    uri = URI.parse(URL)
    response = Net::HTTP.get_response(uri)
    response.body
  end
 

def game_list
      games = JSON.parse(self.get_games)
      games.collect do |game|
        game  
      end
    end
end 

    games = API_parser.new
puts games.game_list.uniq


#need to parse through a list of games and allow a user to ask to see metacritic score (rating), genre, platform, synopsis