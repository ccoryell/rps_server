class HomeController < ApplicationController
  
  def index
    if current_client != nil
      @challengable_users = current_client.challengable_users
    end
  end  

end
