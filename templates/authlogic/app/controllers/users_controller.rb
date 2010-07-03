class UsersController < InheritedResources::Base
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  update! do |success, failure|
    success.html { redirect_to account_url }
    failure.html { render :action => :edit }
  end

private
  def resource
    @user = @current_user
  end
end
