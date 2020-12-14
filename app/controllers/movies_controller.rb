class MoviesController < ApplicationController
    def index
        movies = Movie.last
        render json: movies, status: :ok
    end
end
