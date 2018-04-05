
class SemestersController < ApplicationController

  get '/semesters' do
    if session[:id]
      @user = User.find_by_id(session[:id])
      @semesters = @user.semesters
      erb :'semesters/semesters'
    else
      redirect to '/login'
    end
  end

  get '/semesters/new' do
    if session[:id]
      erb :'semesters/new'
    else
      redirect to '/login'
    end
  end

  post '/semesters/new' do
    if user = User.find_by_id(session[:id])
      if user.semesters << Semester.new(season: params[:season], year: params[:year])
        semester = user.semesters.last
        redirect to :"/semesters/#{semester.id}"
      end
    else
      redirect to '/semesters'
    end
  end

  get '/semesters/:id' do
    if session[:id]
      @semester = Semester.find_by_id(params[:id])
      erb :'/semesters/show'
    else
      redirect to '/login'
    end
  end

  get '/semesters/:id/edit' do
    if session[:id]
      user = User.find_by_id(session[:id])
      @semester = Semester.find_by_id(params[:id])
      if user.semesters.include?(@semester)
        erb :'semesters/edit'
      end
    else
      redirect to '/login'
    end
  end

  patch '/semesters/:id' do
    if session[:id]
      if params[:season] == ""
        redirect to "/semesters/#{params[:id]}/edit"
      else
        @semester = Semester.find_by_id(params[:id])
        @semester && @semester.user == current_user
        @semester.season = params[:season]
        @semester.year = params[:year]
        @semester.save
        erb :'semesters/show'
      end
    else
      redirect to '/login'
    end
  end

  post '/semesters/:id' do
    if session[:id]
      @semester = Semester.find_by_id(params[:id])
      erb :'/semesters/show'
    else
      redirect to '/login'
    end
  end

  delete '/semesters/:id/delete' do
    if session[:id]
      @semester = Semester.find_by_id(params[:id])
      @semester.delete
      redirect to '/semesters'
    end
  end
end
