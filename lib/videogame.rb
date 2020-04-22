

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
        !!@rating
    end 

    def populate_game(description, rating, metacritic, website, genres)
        @description = description
        @rating = rating 
        @metacritic = metacritic
        @website = website 
        @genres = genres 
    end 

    def all_information
        <<-DESC      
#{name}  

Rating: #{rating}     Metacritic Score: #{metacritic}

Genre(s): #{genres.join(", ")}

Synopsis:
#{description}


For more information, visit:

#{website}
        DESC
    end 
    
end 
