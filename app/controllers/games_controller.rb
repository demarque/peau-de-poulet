# encoding: utf-8

class GamesController < ApplicationController
  def index
    @game = Game.new
    @game.name = session[:name]
    @leaders = Game.where(:cheater.ne => true).desc(:score).limit(3)
  end


  def create
    game = Game.new params[:game]
    game.cheater = (params[:game][:score].to_i > 275)
    game.save

    session[:name] = params[:game][:name]

    if game.cheater
      redirect_to 'http://chickenonaraft.com/'
    else
      redirect_to games_path
    end
  end
end
