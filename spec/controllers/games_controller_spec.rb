require 'spec_helper'

describe GamesController do
  integrate_views
  before do
    @challenger = Client.create
    @opponent = Client.create
  end

  describe "#new" do
    context "with valid data" do
      it "should show a page with buttons" do
        sign_in @challenger
        get :new, :opponent_id => @opponent.id
        response.should be_success
        response.body.should =~ /Rock/
      end
    end

    context "with invalid data" do
      it "should redirect to home page if invalid user" do
       get :new, :opponent_id => -1
       response.should be_redirect
      end

      it "should redirect because I cannot challenge myself" do
        sign_in @challenger
        get :new, :opponent_id => @challenger.id
        response.should be_redirect
      end
      
    end
  end
  
  describe "#show" do
    # it "should display the game page with game id" do 
    #   @game = Game.create(:challenger => @challenger, :opponent=>@opponent, :is_accepted=>true)
    #   get :show, :game_id=>@game.id
    #   puts "GAMES SHOW #{response.body}"
    #   response.body.should =~ /#{@game.id}/
    # end
    #     
  end
  
  
  describe "#accept" do
    describe "with valid data" do

      describe "game needs to be accepted" do
        before do
          @game = Game.new
          @game.challenger = @challenger
          @game.opponent = @opponent
          @game.save
        end
        
        it "should redirect to game page" do
          get :accept, :game_id => @game.id
          response.should redirect_to("/games/#{@game.id}")
        end

        it "should 'accept' the game" do
          get :accept, :game_id => @game.id
          @game.reload
          @game.state.should == "accepted"
        end
      end

      describe "game already accepted" do
        it "should be idempotent" do
        end
      end


    end
    
    describe "with invalid data" do      
      describe "game doesn't exists" do
        it "should return an error" do
        end
      end
      describe "game has already been played" do
        it "should return an error" do
        end
      end
    end
  end

  
  describe "#create" do
    it "should have a valid restful route" do
      params_from(:post, "/games").should == {:controller => "games", :action => "create"}
    end

    context "with valid data" do
      before do
        sign_in @challenger
        @game_count = Game.all.length
        post :create, :play => "rock", :opponent_id => @opponent.id
        
      end
      it "should create a new game and a new play for the logged in user" do
        Game.all.length.should == @game_count + 1
      end
      it "should create a play for the challenger" do
        game = Game.find :first, :conditions => {:challenger_id => @challenger.id, :opponent_id => @opponent.id, :is_accepted => false}
        play = Play.find :first, :conditions => {:game_id => game.id, :client_id => @challenger.id}
        play.should_not == nil
        play.kind.should == "rock"
      end
    end


    it "should be not let you challenge if you've already challenged" do
      @challenger = Client.create
      @opponent = Client.create
      @pending_game = Game.create(:challenger => @challenger, :opponent => @opponent, :is_accepted => false)
      sign_in @challenger
      
      post :create, :play => "rock", :opponent_id => @opponent.id
      
      flash[:already_challenged_that_user].should == true  
    end
    
  end
end
