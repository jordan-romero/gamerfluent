# require 'net/http'
# require 'open-uri'
# require 'json'


class Gamerfluent::API_parser

  BASE_URL = "https://api.rawg.io/api/"

  def self.get_games
    url = BASE_URL + "games"
    result = HTTParty.get(url)
    Gamerfluent::Video_game.mass_create_from_api([])
  end 
end 
 



#need to parse through a list of games and allow a user to ask to see metacritic score (rating), genre, synopsis