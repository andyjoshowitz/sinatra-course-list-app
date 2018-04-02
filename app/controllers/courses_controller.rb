class CoursesController < ApplicationController

  get "/courses" do
    redirect_if_not_logged_in
    @courses = Course.all
    erb :'courses/courses'
  end

  get "/courses/new_course" do
    redirect_if_not_logged_in
    @error_message = params[:error]
    erb :'courses/new_course'
  end

  get "/courses/:id/edit" do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @course = Course.find(params[:id])
    erb :'courses/edit'
  end

  post "/courses/:id" do
    redirect_if_not_logged_in
    @course = Course.find(params[:id])
    unless Course.valid_params?(params)
      redirect "/courses/#{@course.id}/edit?error=invalid course"
    end
    @course.update(params.select{|k|k=="name" || k=="capacity"})
    redirect "/courses/#{@course.id}"
  end

  get "/courses/:id" do
    redirect_if_not_logged_in
    @course = Course.find(params[:id])
    erb :'courses/show_courses'
  end

  post "/courses" do
    redirect_if_not_logged_in

    unless Course.valid_params?(params)
      redirect "/courses/new?error=invalid course"
    end
    Course.create(params)
    redirect "/courses/courses"
  end
end
