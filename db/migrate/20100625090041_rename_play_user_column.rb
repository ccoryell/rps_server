class RenamePlayUserColumn < ActiveRecord::Migration
  def self.up
    rename_column :plays, :user_id, :client_id 
  end

  def self.down
        rename_column :plays, :client_id, :user_id 
  end
end
