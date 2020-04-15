#should instatiate video games with a name and id 
#should store all games into an array of games
#should iterate through the games to display different games 
#should be able to save all of the games 
\

class Gamerfluent::VideoGame

    @@all = []

    attr_accessor :id, :name, :description, :rating, :metacritic, :website, :genres 

    def self.all
        @@all
    end 

    def self.mass_create_from_api(gamearr)
        gamearr.each do |gamehash|
            new(gamehash["id"], gamehash["name"])
        end 
    end 

    def initialize (id, name)
        @id, @name = id, name 
        @description, @rating, @metacritic, @website = nil, nil, nil, nil 
        @genres = []
        save
    end 

    def to_s 
        name.capitalize 
    end 

    def save 
        @@all << self 
    end 

    def informed?
        !!@description
    end 

    def populate_game(description, rating, metacritic, website)
        @description = description
        @rating = rating 
        @metacritic = metacritic
        @website = website 
    end 

    def all_information
        "#{name}  #{id}\n\n Rating: #{rating}     MetacriticScore: #{metacritic}\n\n Synopsis:\n#{description}\n\n\n\For more information, visit:\n\n#{website}"
    end 
end 
