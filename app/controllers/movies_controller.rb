class MoviesController < ApplicationController
  def index
    movies = Movie.all
    if movies.empty?
      render json: {message: "Empty list"}, status: :ok
    else
      render json: movies, status: :ok
    end
  end
end
