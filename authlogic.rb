generate "authlogic:session user_session"
generate "model User login:string email:string crypted_password:string password_salt:string persistence_token:string single_access_token:string perishable_token:string"

route "root :to => 'home#show'"
route "resource :user_session"
route "resources :users"
route "resource :account, :controller => 'users'"

file "app/controllers/application_controller.rb", <<-END
class ApplicationController < ActionController::Base
  include InheritedResources::DSL
  protect_from_forgery
  layout 'application'

  helper_method :current_user_session, :current_user
  
  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.fullpath
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end
END

get "http://github.com/flyerhzm/rails3-template/raw/master/templates/authlogic/app/models/user.rb", "app/models/user.rb"
get "http://github.com/flyerhzm/rails3-template/raw/master/templates/authlogic/app/controllers/user_sessions_controller.rb", "app/controllers/user_sessions_controller.rb"
get "http://github.com/flyerhzm/rails3-template/raw/master/templates/authlogic/app/views/user_sessions/new.html.haml", "app/views/user_sessions/new.html.haml"
get "http://github.com/flyerhzm/rails3-template/raw/master/templates/authlogic/app/controllers/users_controller.rb", "app/controllers/users_controller.rb"
get "http://github.com/flyerhzm/rails3-template/raw/master/templates/authlogic/app/views/users/new.html.haml", "app/views/users/new.html.haml"
get "http://github.com/flyerhzm/rails3-template/raw/master/templates/authlogic/app/views/users/show.html.haml", "app/views/users/show.html.haml"
get "http://github.com/flyerhzm/rails3-template/raw/master/templates/authlogic/spec/factories/users.rb", "spec/factories/users.rb"
get "http://github.com/flyerhzm/rails3-template/raw/master/templates/authlogic/spec/models/user_spec.rb", "spec/models/user_spec.rb"
get "http://github.com/flyerhzm/rails3-template/raw/master/templates/authlogic/spec/controllers/user_sessions_controller_spec.rb", "spec/controllers/user_sessions_controller_spec.rb"
get "http://github.com/flyerhzm/rails3-template/raw/master/templates/authlogic/features/login.feature", "features/login.feature"
get "http://github.com/flyerhzm/rails3-template/raw/master/templates/authlogic/features/support/paths.rb", "features/support/paths.rb"
get "http://github.com/flyerhzm/rails3-template/raw/master/templates/authlogic/config/locales/en.yml", "config/locales/en.yml"

rake "db:migrate"
rake "db:test:prepare"

git :add => "."
git :commit => %Q(-am "add authlogic by flyerhzm's rails3-template")
