class GamesController < ApplicationController

  def create
    game = Game.new(:opponent_id => params[:opponent_id], :is_accepted => false)
    game.challenger = current_client
    if !game.save
      flash[:already_challenged_that_user] = true
    else
      Play.create(:client => current_client, :play => params[:play], :game => game)
    end
    redirect_to :controller => 'home', :action => 'index'   
  end
  
  def new
    @opponent = Client.find_by_id params["opponent_id"]
    @game = Game.new :opponent => @opponent
    
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
