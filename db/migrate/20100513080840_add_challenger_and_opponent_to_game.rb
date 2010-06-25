class AddChallengerAndOpponentToGame < ActiveRecord::Migration
  def self.up
    add_column :games, :challenger_id, :integer
    add_column :games, :opponent_id, :integer
  end

  def self.down
    remove_column :games, :challenger_id
    remove_column :games, :opponent_id
  end
end
