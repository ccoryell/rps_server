require 'spec_helper'

describe Game do
  before(:each) do
    @valid_attributes = {
      :challenger => Client.create,
      :opponent => Client.create
    }
  end

  it "should create a new instance given valid attributes" do
    Game.create!(@valid_attributes)
  end
  
  it "should create new games that are open" do
    game = Game.create!(@valid_attributes)
    game.state.should == "open"
  end
  
  it "should respond to the accept method" do
    game = Game.create!(@valid_attributes)
    game.accept
    game.state.should == "accepted"
  end
end
