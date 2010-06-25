class AddPlaysTable < ActiveRecord::Migration
  def self.up
    create_table :plays do |t|
      t.integer :user_id 
      t.integer :game_id
      t.string  :play, :limit => 1
      t.timestamps
    end
  end

  def self.down
    drop_table :plays
  end
end
