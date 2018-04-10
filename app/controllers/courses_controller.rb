
class CoursesController < ApplicationController

  get '/semesters/:id/courses' do
    if session[:id]
      @user = User.find_by_id(session[:id])
      @semester = @user.semesters.find_by_user_id(session[:id])
      @courses = @semester.courses
      erb :'courses/courses'
    else
      redirect to '/semesters'
    end
  end

  get '/semesters/:id/courses/new' do
    if session[:id]
      @semester = Semester.find_by_id(params[:id])
      erb :'courses/new_course'
    else
      redirect to '/courses'
    end
  end

  post '/semesters/:id/courses/new' do
    if semester = Semester.find(params[:id])
      course = Course.new(title: params[:title], department: params[:department], professor: params[:professor], location: params[:location], user_id: session[:id])
      if course.save
        User.find(session[:id]).semesters.find(params[:id]).courses << course
        redirect to :"/courses/#{course.id}"
      else
        redirect to "/semesters/:id/courses/new"
      end
    else
      redirect to '/login'
    end
  end

  get '/courses/:id' do
    if session[:id]
      @user = User.find_by_id(session[:id])
      @semester = @user.semesters.find_by_user_id(session[:id])
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
      @course = Course.find_by_id(params[:id])
      semester = @course.semester_id
      @semester = Semester.find_by_id(semester)
      if params[:title] == ""
        redirect to "/courses/#{params[:id]}/edit"
      else
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
#:course_id
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
      @course = Course.find_by_id(params[:id])
      @course.delete
      redirect to '/courses'
#      binding.pry
#      user = User.find_by_id(session[:id])
#      course = Course.find_by_id(params[:id])
#      if i = user.courses.find_index(course)
#        user.courses[i].delete
#   else
#      redirect to 'login'
    end
  end
end
