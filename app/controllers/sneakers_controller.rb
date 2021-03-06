class SneakersController < ApplicationController
  get '/sneakers' do #index
    if logged_in?
      @sneakers = []
      @s = Sneaker.all
      @s.each do |s|
        if s.user_id == session[:user_id]
          @sneakers << s
        end
      end
      @sneakers
      erb :"/sneakers/index"
    else
      redirect to "/login"
    end
  end

  get '/sneakers/new' do #new
    if logged_in?
      erb :"/sneakers/new"
    else
      redirect to "/login"
    end
  end

  post '/sneakers' do
    if params[:context] != ""
      @sneaker = Sneaker.new(params)
      @sneaker.user = current_user(session)
      @sneaker.save
      redirect to "/sneakers/#{@sneaker.id}"
    else
      redirect to "/sneakers/new"
    end
  end

  get '/sneakers/:id' do
    if logged_in?
      @sneaker = Sneaker.find_by_id(params[:id])
      erb :"/sneakers/show"
    else
      redirect to "/login"
    end
  end

  get '/sneakers/:id/edit' do
    if logged_in?
      @sneaker = Sneaker.find_by_id(params[:id])
      if @sneaker && @sneaker.user == current_user(session)
        erb :"/sneakers/edit"
      end
    else
      redirect to "/login"
    end
  end

  patch '/sneakers/:id' do
    @sneaker = Sneaker.find_by_id(params[:id])
    if params[:context] != ""
      @sneaker.update(context: params[:context])
      redirect to "/sneakers/#{@sneaker.id}"
    else
      redirect to "/sneakers/#{@sneaker.id}/edit"
    end
  end

  delete '/sneakers/:id/delete' do
    if logged_in?
      @sneaker = Sneaker.find_by_id(params[:id])
      if @sneaker && @sneaker.user == current_user(session)
        @sneaker.delete
      end
      redirect to "/sneakers"
    else
      redirect to "/login"
    end
  end


end
