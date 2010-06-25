class ClientsController < ApplicationController
  before_filter :authenticate_client!, :only => :challenges
  
  def create
    client = Client.create
    render :text=>client.id
  end

  def login
  end

  def challenges
    @challenges = Game.open_games_for(current_client.id)
  end

end
