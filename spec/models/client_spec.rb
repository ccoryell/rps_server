require 'spec_helper'

describe Client do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    Client.create!(@valid_attributes)
  end
  
  describe "#opponents" do
    # it "should return an opponent" do
    #     @me = Client.create
    #     @other = Client.create  
    #     game = Game.create(:challenger => @me, :opponent => @other)
    #     @me.opponents.first.should == @other
    #   end
  end
  
  describe "#challengable_users" do
    before do
      @me = Client.create
      @other = Client.create  
    end
      
    it "should include users on the system who haven't challenged you" do
        @me.challengable_users.length.should == 1
        @me.challengable_users.first.should == @other 
    end

    # it "should not include users who have challenged you" do
    #    challenger = Client.create
    #    game = Game.create(:challenger => challenger, :opponent => @me)
    #    @me.challengable_users.length.should == 1
    #    @me.challengable_users.first.should_not == challenger
    #  end
  end
  
end
