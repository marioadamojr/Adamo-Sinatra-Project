class UsersController < ApplicationController
  get '/signup' do
    if !logged_in?
      erb :"/users/signup"
    else
      redirect to "/sneakers"
    end
  end

  post '/signup' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.new(params)
      @user.save
      session[:user_id] = @user.id
      redirect to "/sneakers"
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if !logged_in?
      erb :"/users/login"
    else
      redirect "/sneakers"
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/sneakers"
    else
      redirect to "/login"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end

  get '/logout' do
      session.destroy
      current_user = nil
      redirect to "/"
  end


end
