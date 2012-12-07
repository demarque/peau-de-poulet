class GamesController < ApplicationController
  def index
    @game = Game.new
    @game.name = session[:name]
    @leaders = Game.where(:cheater.ne => true).desc(:score).limit(3)
  end


  def create
    game = Game.new params[:game]
    game.cheater = true if params[:game][:score].to_i > 75
    game.save

    session[:name] = params[:game][:name]

    if game.cheater
      redirect_to 'http://chickenonaraft.com/'
    else
      redirect_to games_path
    end
  end
end

# Fit the ipad screens
# Enlarge tap zone
# Improve performance
# Add sounds
# Security. Identify cheaters
