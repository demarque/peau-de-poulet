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

    if Rails.env == 'production'
      if game.cheater
        message = "Bien essayé #{game.name}, mais les tricheurs ne sont pas admis!"
        %x(/usr/local/bin/yammo "#{message}")
      elsif Game.count == 0 or game.score >= Game.where(:cheater.ne => true).desc(:score).limit(1).first.score
        message = "#{game.name} à établi un nouveau record! La marque à battre est #{game.score}."
        %x(/usr/local/bin/yammo "#{message}")
      end
    end

    if game.cheater
      redirect_to 'http://chickenonaraft.com/'
    else
      redirect_to games_path
    end
  end
end
