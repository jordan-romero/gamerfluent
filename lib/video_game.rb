#should instatiate video games with a name and genre that cannot be changed
#should store all games into an array of games
#should iterate through the games to display different games 
#should be able to save all of the games 
#should be able to clear all of the games 

class Gamerfluent::Video_game

    @@all = []

    attr_accessor :name, :genres, :rating

    def self.all
        @@all
    end 

    def self.mass_create_from_api(gamearr)
        gamearr.find_all do |gamehash|
            new(gamehash["name"], gamehash["genres"], gamehash["rating"])
        end 

        # gamearr.map do |gamehash|
        #     gamehash.select do |key, value|
        #       [:name, :genres, :rating].include? key
        #   end
        #  end 

    end 

    def initialize (name, genres, rating = nil)
        @name, @genres, @rating = name, genres, rating 
        save
    end 

    def save 
        @@all << self 
    end 

end 
