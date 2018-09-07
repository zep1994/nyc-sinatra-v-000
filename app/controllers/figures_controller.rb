class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb:'figure/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb:'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb:'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb:'figures/edit'
  end

  post '/figures' do
    @figure = Figure.create(name: params[:figure][:name])
    if params[:figure][:landmarks_ids]
      @figure.landmarks_ids = params[:figure][:landmarks_ids]
    end
    if !params[:landmark][:name].empty?
      landmark = Landmark.find_or_create_by(name: params[:landmark][:name])
      @figure.landmarks << landmark
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
      @figure.figure_titles.create(title_id: title_id)
    end
  end
  @figure.save
  redirect :"figures/#{@figure.id}"
end
