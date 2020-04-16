# require 'net/http'
# require 'open-uri'
# require 'json'


class Gamerfluent::API_parser

  BASE_URL = "https://api.rawg.io/api/"

  def self.get_games(page = 1)
    url = BASE_URL + "games?page=#{+1}"
    result = HTTParty.get(url)
    Gamerfluent::VideoGame.mass_create_from_api(result["results"])
      return {
         next: result["next"],
        previous: result["previous"]
      }
  end 

      def self.get_more_game_info(videogame)
      url = BASE_URL + "games/" + videogame.id.to_s
      result = HTTParty.get(url)
      description  = result["description"]
      description_text = Nokogiri::HTML(description).text
      description = description_text
      rating = result["rating"]
      metacritic = result["metacritic"]
      website = result["website"]
      genres = result["genres"].map {|h| h["name"]}
      videogame.populate_game(description, rating, metacritic, website, genres)
    end 
end 

 



