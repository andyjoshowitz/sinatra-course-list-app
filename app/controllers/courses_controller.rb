
class CoursesController < ApplicationController

  get '/courses' do
    if session[:id]
      @user = User.find_by_id(session[:id])
      @courses = @user.courses
      erb :'courses/courses'
    else
      redirect to '/login'
    end
  end

  get '/courses/new' do
    if session[:id]
      erb :'courses/new_course'
    else
      redirect to '/login'
    end
  end

  post '/courses/new' do
    if user = User.find_by_id(session[:id])
      if user.courses << Course.new(title: params[:title], department: params[:department], professor: params[:professor], location: params[:location])
        course = user.courses.last
        redirect to :"/courses/#{course.id}"
      end
    else
      redirect to '/courses/new'
    end
  end

  get '/courses/:id' do
    if session[:id]
      @course = Course.find_by_id(params[:id])
      erb :'/courses/show_courses'
    else
      redirect to '/login'
    end
  end

  get '/courses/:id/edit' do
    if session[:id]
      user = User.find_by_id(session[:id])
      @course = Course.find_by_id(params[:id])
      if user.courses.include?(@course)
        erb :'courses/edit'
      end
    else
      redirect to '/login'
    end
  end

  patch '/courses/:id' do
    if session[:id]
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
        erb :'courses/show_courses'
      end
    else
      redirect to '/login'
    end
  end

  post '/courses/:id' do
    if session[:id]
      @course = Course.find_by_id(params[:id])
      erb :'/courses/show_courses'
    else
      redirect to '/login'
    end
  end

  delete '/courses/:id/delete' do
    if session[:id]
      user = User.find_by_id(session[:id])
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
