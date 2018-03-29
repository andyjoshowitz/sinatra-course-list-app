class UsersController < ApplicationController

  get '/users/:id' do
    if !logged_in?
      redirect '/courses'
    end

    @user = User.find(params[:id])
    if !@user.nil? && @user == current_user
      erb :'users/show'
    else
      redirect '/courses'
    end
  end

  get '/signup' do
    if !session[:user_id]
      erb :'users/new_user'
    else
      redirect to '/clubs'
    end
  end

  post '/signup' do
    if params[:name] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(:name => params[:name], :password => params[:password])
      session[:user_id] = @user.id
      redirect '/courses'
    end
  end

  get '/login' do
    #@error_message = params[:error]
    if !session[:user_id]
      erb :'users/login'
    else
      redirect '/courses'
    end
  end

  post '/login' do
    user = User.find_by(:name => params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/courses"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.destroy
      redirect to '/login'
    elsecourses
      redirect to '/'
    end
  end

end#
