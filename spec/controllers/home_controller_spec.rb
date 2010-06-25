require 'spec_helper'

describe HomeController do
  describe "#index" do
    context "when not logged in" do
      it "should work" do
        get :index
        response.should be_success
      end
    end
    
    context "when logged in" do
      before do
        @user = Client.create :email => 'user@example.com'
        sign_in @user
      end
      
      it "should display list of unchallenged users" do
        @other_user = Client.create (:email => 'other_user@example.com')
        get :index
        
        challengable_users = assigns[:challengable_users]
        challengable_users.length.should == 1
        challengable_users.first.should == @other_user
      end
      
      it "should display users you have challenged" do
        @opponent = Client.create
      end
      
      it "should display open challenges" do
        @challenger = Client.create
      end
      
    end
  end
end