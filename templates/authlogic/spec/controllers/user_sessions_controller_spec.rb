require 'spec_helper'

describe UserSessionsController do
  
  def mock_user_session(stubs={})
    @mock_user_session ||= mock_model(UserSession, stubs)
  end

  describe "Get new" do
    it "should get new" do
      get :new
      response.should render_template('new')
    end
  end

  describe "Post create" do
    before :each do
      @user = Factory.create(:user_flyerhzm)
    end

    it "should create user session" do
      post :create, :user_session => { :login => 'flyerhzm', :password => 'flyerhzm' }
      user_session = UserSession.find
      user_session.should_not be_nil
      user_session.user.should == @user
      response.should redirect_to root_url
    end

    it "should create user session for invalid password" do
      post :create, :user_session => { :login => 'flyerhzm', :password => '123456' }
      UserSession.find.should be_nil
      response.should render_template('new')
    end
  end

  describe "DELETE destroy" do
    before :each do
      @user = Factory.create(:user_flyerhzm)
    end

    it "should destroy user session" do
      UserSession.create(@user)
      delete :destroy
      assert_nil UserSession.find
      assert_redirected_to new_user_session_url
    end
  end
end
