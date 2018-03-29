class CoursesController < ApplicationController

  get "/coucoursesrses" do
    redirect_if_not_logged_in
    @courses = Course.all
    erb :'golf_bags/index'
  end

  get "/courses/new" do
    redirect_if_not_logged_in
    @error_message = params[:error]
    erb :'courses/new'
  end

  get "/courses/:id/edit" do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @course = Course.find(params[:id])
    erb :'courses/edit'
  end

  post "/bags/:id" do
    redirect_if_not_logged_in
    @course = Course.find(params[:id])
    unless Course.valid_params?(params)
      redirect "/courses/#{@bag.id}/edit?error=invalid golf bag"
    end
    @course.update(params.select{|k|k=="name" || k=="capacity"})
    redirect "/courses/#{@bag.id}"
  end

  get "/courses/:id" do
    redirect_if_not_logged_in
    @course = Course.find(params[:id])
    erb :'courses/show'
  end

  post "/courses" do
    redirect_if_not_logged_in

    unless Course.valid_params?(params)
      redirect "/courses/new?error=invalid golf bag"
    end
    Course.create(params)
    redirect "/courses"
  end
end
