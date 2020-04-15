# require 'net/http'
# require 'open-uri'
# require 'json'


class Gamerfluent::API_parser

  BASE_URL = "https://api.rawg.io/api/"

  def self.get_games
    url = BASE_URL + "games?dates=2019-01-01,2019-12-31&ordering=-rating"
    result = HTTParty.get(url)
    Gamerfluent::VideoGame.mass_create_from_api(result["results"])
  end 

  def self.get_more_game_info(videogame)
    id = videogame.id 
    result = HTTParty.get(id)
    binding.pry
  end 
end 
 



