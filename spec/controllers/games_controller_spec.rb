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
        response.body.should =~ /rock/
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
          response.should redirect_to("/games/show/#{@game.id}")
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
    describe "with valid data" do
      before do
        @game_count = Game.count
   
        get :create,
              :challenger_id => @challenger.id,
              :opponent_id   => @opponent.id
       end
      
      it "should create a new game" do
        Game.count.should == @game_count +1
      end
      
      it "should return the new game id" do
        new_game = Game.find(:all).last.id.to_s
        response.body.should == new_game
      end
      
      it "should create the new game with correct players" do
        new_game = Game.find(:all).last
        new_game.challenger.id.should == @challenger.id
        new_game.opponent.id.should == @opponent.id
      end
      
    end
    
    describe "with preexisting game" do
      
      before do
        @challenger = Client.create
        @opponent = Client.create
        get :create,
              :challenger_id => @challenger.id,
              :opponent_id   => @opponent.id
        @pre_existing_game = Game.find(:all).last
        get :create,
              :challenger_id => @challenger.id,
              :opponent_id   => @opponent.id            
      end

      it "should return the pre-existing game" do
        response.body.should == @pre_existing_game.id.to_s
      end
      
    end
    
    describe "with non-existent players" do
      before do
        get :create,
                :challenger_id => "foo",
                :opponent_id   => "bar"
      end
      it "should return an error message" do
        response.body.should =~ /error/
      end
    end
    
  end
end
