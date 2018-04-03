class UsersController < ApplicationController
  get '/signup' do
    if !session[:user_id]
      erb :'users/new_user'
    else
      redirect to '/courses'
    end
  end

  post '/signup' do
    if params[:name] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(:name => params[:name], :email => params[:email], :password => params[:password])
      session[:user_id] = @user.id
      redirect '/courses'
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :'users/login'
    else
      redirect to '/courses'
    end
  end

  post '/login' do
    if @user = User.find_by(email: params["email"], password: params["password"])
      session[:id] = @user.id
    else
      redirect '/login'
    end
    redirect '/show'
  end

  get '/show' do
    if !session[:user_id]
      erb :'users/show'
    else
      redirect to '/courses'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end
end
