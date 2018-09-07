class LandmarksController < ApplicationController

  get '/landmarks' do
   @landmarks = Landmark.all
   erb:'landmarks/index'
  end

  get '/landmarks/new' do
   @titles = Title.all
   @figure = Figure.all
   erb:'landmarks/new'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb:'landmark/show'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    @figures = Figure.all
    @titles = Title.all
    erb:'landmarks/edit'
  end

  post '/landmarks' do
    @landmark = Landmark.create(name: params[:landmark][:name])
    if !params[:landmark][:year_completed].empty?
      @landmark.year_completed = params[:landmark][:year_completed]
    end
    if params[:landmark][:landmark_id]
      @landmark.figure_id = params[:landmark][:figure_id]
    end
  if !params[:figure][:name].empty?
    figure = Figure.find_or_create_by(name: params[:figure][:name])
      @landmark.figures << figure
  end
  if params[:landmark][:title_ids]
    @landmark.title_ids = params[:landmark][:title_ids]
  end
  if !params[:title][:name].empty?
    title = Title.find_or_create_by(name: params[:title][:name])
    @landmark.title << title
  end
  @landmark.save
  redirect :"landmarks/#{@landmark.id}"
end

post '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    if !params[:landmark][:name].empty?
      @landmark.name = params[:landmark][:name]
    end
    if !params[:landmark][:year_completed].empty?
      @landmark.year_completed = params[:landmark][:year_completed]
    end
    if params[:landmark][:figure_id]
      @landmark.figure_id = params[:landmark][:figure_id]
    end
    if !params[:figure][:name].empty?
      figure = Figure.find_or_create_by(name: params[:figure][:name])
      @landmark.figures << figure
    end
    if params[:landmark][:title_ids]
      @landmark.title_ids = params[:landmark][:title_ids]
    end
    if !params[:title][:name].empty?
      title = Title.find_or_create_by(name: params[:title][:name])
      @landmark.title << title
    end
    @landmark.save
    redirect :"landmarks/#{@landmark.id}"
  end
end
