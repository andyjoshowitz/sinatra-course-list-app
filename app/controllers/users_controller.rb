class UsersController < ApplicationController
  get '/signup' do
    if !session[:user_id]
      erb :'users/new_user'
    else
      redirect to '/show'
    end
  end

  post '/signup' do
    @user = User.new(name: params[:name], email: params[:email], password: params[:password])
    if new_user.save
      session[:user_id] = new_user[:id]
      redirect to '/courses'
    else
      redirect to '/signup'
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
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/courses'
    else
      redirect to '/login'
    end
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
    redirect to '/login'
  end
end
