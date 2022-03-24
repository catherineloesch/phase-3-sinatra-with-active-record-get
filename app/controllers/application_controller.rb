class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  get '/' do
    '<h2>Hello <em>World</em>!</h2>'
  end

  get '/games' do
    # get all the games from the database
    # games = Game.all
    # games = Game.all.order(:title)
    games = Game.all.order(:title).limit(10)

    # return a JSON response with an array of all the game data
    games.to_json
  end

   get '/games/:id' do
    # use the :id syntax to create a dynamic route
    # look up the game in the database using its ID
    game = Game.find(params[:id])
    # send a JSON-formatted response of the game data
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
    end

end
