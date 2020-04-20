class FiguresController < ApplicationController


get '/figures/new' do
      @titles = Title.all
      @landmarks = Landmark.all
      @all_figures = Figure.all

      erb :'figures/new'
    end

    post '/figures' do

      @figure = Figure.create(params["figure"])

      title_params = params["title"]["name"]
      landmark_params = params["landmark"]

      if !title_params.empty?
        title = Title.create(params["title"])
        @figure.titles << title
      end

      if !landmark_params.empty?
          landmark = Landmark.create(landmark_params)
          @figure.landmarks << landmark
      end
      @figure.save

      redirect to "/figures/#{@figure.id}" #moves to route GET '/figures/:id'
    end

    get '/figures/:id' do

      @figure = Figure.find_by(id: params["id"])

      erb :'figures/show'
    end

    get '/figures' do
      @figures = Figure.all

      erb :'figures/all'
    end

    get '/figures/:id/edit' do
      @figure = Figure.find_by(id: params["id"])

      erb :'figures/edit'
    end

    patch '/figures/:id' do
      @figure = Figure.find(params["id"])
      @figure.name = params["figure"]["name"]

      @figure.landmarks.each do |landmark|
        if landmark.figure_id == params["id"].to_i
          old_landmark = Landmark.find_by(figure_id: params["id"])
          old_landmark.name = params["landmark"]["name"]
          old_landmark.save
        end
      end #each iteration
      @figure.save

      redirect to "/figures/#{@figure.id}"
    end

end
