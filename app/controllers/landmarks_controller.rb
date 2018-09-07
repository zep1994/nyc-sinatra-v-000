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
  end
  if !params[:title].empty?
    params[:figure][:title_ids] = [] if !params[:figure][:title_ids])
      if !params[:title][:name].split(",").map!(&:strip).each do |name|
        title = Title.find_or_create_by(name: name)
        params[:figure][:title_ids] << title.id
      end
  end
    params[:figure][:title_ids].each do |title_id|
      @landmark.figure_titles.create(title_id: title_id)
    end
  end
  @landmark.save
  redirect :"figures/#{@figure.id}"

  post '/figures/:id' do
    @figure = Figure.find(params[:id])
    if !params[:figure][:name].empty?
      @figure.name = params[:figure][:name]
    end
    if params[:figure][:landmarks_ids]
      @figure.landmarks_ids = params[:figure][:landmarks_ids]
    end
    if !params[:landmark][:name].empty?
      landmark = Landmark.find_or_create_by(name: params[:landmark][:name])
      @figure.landmarks << landmark
    end
    if !params[:title].empty?
      params[:figure][:title_id] = [] if !params[:figure][:title_ids]
      if !params[:title][:name].empty?
        params[:title][:name].split(",").map!(&:strip).each do |name|
          title = Title.find_or_create_by(name: name)
          params[:figure][:title_id] << title.id
        end
      end
      (@figure.title_ids - params[:figure][:title_ids]).each do |title_id|
        @figure.figure_titles.find_by(title_id: title_id).destroy
      end
      (params[:figure][:title_ids] - @figure.title_ids).each do |title_id|
        @figure.figure_titles.create(title_id: title_id)
      end
    end
    @figure.save
    redirect :"figures/#{@figure.id}"
  end
end
