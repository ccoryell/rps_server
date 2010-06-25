class Game < ActiveRecord::Base
  belongs_to :challenger, :class_name => "Client"
  belongs_to :opponent, :class_name => "Client"

  validates_presence_of :challenger
  validates_presence_of :opponent
  
  validate :no_other_challenge_in_progress, :on => :save

  def self.open_games_for(opponent_id)
    Game.find(:all, :conditions => {:opponent_id=>opponent_id})
  end

  def state
    self.is_accepted ? "accepted" : "open"
  end

  def accept
    self.is_accepted = true
    self.save
  end
  
  def no_other_challenge_in_progress
    return if self.is_accepted == true  
        
    other_challenge = Game.find(:first, :conditions => {:opponent_id => self.opponent_id, 
                                                        :challenger_id => self.challenger.id, 
                                                        :is_accepted => false})    
    errors.add(:opponent_id, ' has already been challenged by you') if 
      other_challenge != nil
  end
  
end
