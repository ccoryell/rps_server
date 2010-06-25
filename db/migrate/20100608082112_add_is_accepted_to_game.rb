class AddIsAcceptedToGame < ActiveRecord::Migration
  def self.up
    add_column :games, :is_accepted, :boolean, :default=>false
  end

  def self.down
    remove_column :games, :is_accepted
  end
end
