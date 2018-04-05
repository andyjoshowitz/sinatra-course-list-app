class UsersController < ApplicationController
  get '/signup' do
    if !session[:id]
      erb :'users/new_user'
    else
      redirect to '/semesters'
    end
  end

  post '/signup' do
    if params[:name] == "" || params[:password] == ""
      redirect to '/semesters'
    else
      @user = User.create(:name => params[:name], :email => params[:email], :password => params[:password])
      session[:id] = @user.id
      redirect '/semesters'
    end
  end

  get '/login' do
    if !session[:id]
      erb :'users/login'
    else
      redirect to '/semesters'
    end
  end

  post '/login' do
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect '/show'
    else
      redirect '/login'
    end
  end

  get '/show' do
    if !session[:id]
      erb :'users/show'
    else
      redirect to '/semesters'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end
end
