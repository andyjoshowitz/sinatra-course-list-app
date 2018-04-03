
class CoursesController < ApplicationController

  get '/courses' do
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
      @courses = Course.all
      erb :'courses/courses'
    else
      redirect to '/login'
    end
  end

  get '/courses/new' do
    if session[:user_id]
      erb :'courses/new_course'
    else
      redirect to '/login'
    end
  end

  post '/courses/new' do
    if user = User.find_by_id(session[:user_id])
      if user.courses << Course.new(title: params[:title], department: params[:department], professor: params[:professor], location: params[:location])
        course = user.courses.last
        redirect to :"/courses/#{course.id}"
      end
    else
      redirect to '/courses/new_course'
    end
  end

  get '/courses/:id' do
    if session[:user_id]
      @course = Course.find_by_id(params[:id])
      erb :'/courses/show_courses'
    else
      redirect to '/login'
    end
  end

  get '/courses/:id/edit' do
    if session[:user_id]
      user = User.find_by_id(session[:user_id])
      @course = Course.find_by_id(params[:id])
      if user.courses.include?(@course)
        erb :'courses/edit'
      end
    else
      redirect to '/login'
    end
  end

  patch '/courses/:id' do
    if logged_in?
      if params[:title] == ""
        redirect to "/courses/#{params[:id]}/edit"
      else
        @course = Course.find_by_id(params[:id])
        @course && @course.user == current_user
        @course.title = params[:title]
        @course.department = params[:department]
        @course.professor = params[:professor]
        @course.location = params[:location]
        @course.save
        redirect to "/courses/#{@course.id}"
      end
    else
      redirect to '/login'
    end
  end

  post '/courses/:id' do
    if session[:user_id]
      @course = Course.find_by_id(params[:id])
      erb :'/courses/show_courses'
    else
      redirect to '/login'
    end
  end

  delete '/courses/:id/delete' do
    if session[:user_id]
      user = User.find_by_id(session[:user_id])
      course = Course.find_by_id(params[:id])
      if i = user.courses.find_index(course)
        user.courses[i].delete
        redirect to '/courses'
      end
    else
      redirect to 'login'
    end
  end
end
