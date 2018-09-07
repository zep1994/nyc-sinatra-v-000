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
  
  
end
