require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "test"
  end

  get "/" do
    erb :home_page
  end

  helpers do
    def logged_in?
      !!current_user(session)
    end

    def current_user(session)
      @user = User.find_by_id(session[:user_id])
      if @user.is_a?(User)
        @user
      end
    end
  end

end
