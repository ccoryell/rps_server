class GamesController < ApplicationController

  def create
    if Game.exists?(:challenger_id=>params["challenger_id"], :opponent_id=>params["opponent_id"])
    then 
      game = Game.find(:first, :conditions=>{:challenger_id=>params["challenger_id"], :opponent_id=>params["opponent_id"]})
    else
      game = Game.create(:challenger_id=>params["challenger_id"], :opponent_id=>params["opponent_id"])
    end
    if game.valid?
      render :text=>game.id
    else
      render :text=>"error: invalid game"
    end
  end
  
  def new
    @opponent = Client.find_by_id params["opponent_id"]
    if @opponent == nil || @opponent == current_client
      flash[:opponent_not_found] = true
      redirect_to "/"
    end
  end
  
  def accept
    game = Game.find_by_id(params["game_id"])
    game.accept
    redirect_to :controller=>"games", :action=>"show", :id=>game.id
  end
  
  def show
    @game = Game.find_by_id(params["id"])
  end
  
end
