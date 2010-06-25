class Play < ActiveRecord::Base
  belongs_to :client
  belongs_to :game
    
  def kind
    play
  end
end
