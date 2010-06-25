class HomeController < ApplicationController
  
  def index
    @challengable_users = current_client.challengable_users
  end  

end
