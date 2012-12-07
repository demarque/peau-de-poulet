class GamesController < ApplicationController
  def index
    @game = Game.new
    @game.name = session[:name]
    @leaders = Game.desc(:score).limit(3)
  end


  def create
    game = Game.new params[:game]
    game.save

    session[:name] = params[:game][:name]

    redirect_to games_path
  end
end

# Fit the ipad screens
# Enlarge tap zone
# Improve performance
# Add sounds
# Security. Identify cheaters
# Favicon
