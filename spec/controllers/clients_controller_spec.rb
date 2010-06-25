require 'spec_helper'

describe ClientsController do
  integrate_views
  describe "#log in" do
    # it "should do set a cookie" do
    #   @my_cookies = mock('cookies')
    #   @my_cookies.stub!(:[]=)
    #   controller.stub!(:cookies).and_return(@my_cookies)
    #   @my_cookies.should_receive(:[]=).with(:user_id, 1)    
    #   get :login, :user_id =>1
    # end
  end
  describe "#create" do
    before do
      @client_count = Client.count
      post :create
    end
    
    it "should create a new client" do
      Client.count.should == @client_count + 1
    end
    
    it "should succeed" do
       response.should be_success
    end
    
    it "should return the id of the new client" do
      @last_id = Client.find(:all).last.id.to_s
      response.body.should == @last_id
    end
  end
  
  describe "#challenges" do
    context "when not logged in" do
      it "should ask you to log in" do
        get :challenges
        response.should be_redirect
      end
    end
    
    context "when logged in" do

      it "should return something" do
        @client = Client.create
        sign_in @client
        get :challenges
        response.should be_success
      end

      it "should return other users that have made challenges" do    
           @client   = Client.create        
           @challenger1 = Client.create
           @challenger2 = Client.create
           @first_game = Game.create(:challenger => @challenger1, :opponent => @client)
           @second_game = Game.create(:challenger => @challenger2, :opponent => @client)
           sign_in @client
           
           get :challenges
           response.should be_success
           response.body.should =~ /#{@challenger1.id}/
           response.body.should =~ /#{@challenger2.id}/
         end      
    end    
  end  
end
