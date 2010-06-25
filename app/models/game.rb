class Game < ActiveRecord::Base
  belongs_to :challenger, :class_name => "Client"
  belongs_to :opponent, :class_name => "Client"

  validates_presence_of :challenger
  validates_presence_of :opponent

  def self.open_games_for(opponent_id)
    Game.find(:all, :conditions=>{:opponent_id=>opponent_id})
  end

  def state
    self.is_accepted ? "accepted" : "open"
  end

  def accept
    self.is_accepted = true
    self.save
  end
end
