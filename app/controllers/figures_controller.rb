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
  
  
end
