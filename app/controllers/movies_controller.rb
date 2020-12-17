class MoviesController < ApplicationController
  #listar todos os usuários
  def index
    movies = Movie.all
    if movies.empty?
      render json: {message: "Empty list"}, status: :ok
    else
      render json: movies, status: :ok
    end
  end

  #listar Filme passando ID
  def show
    movie = Movie.find(params[:id])
    if movie.nil?
      render json: {message: "movie not found"}, status: :ok
    else
      render json: movie, status: :ok
    end
  end

  #alterar Filme
  def update
    movie = Movie.find(params[:id])
    if movie.update(movie_params)
        head :no_content
    else
        render json: {errors: movie.errors}, status: :unprocessable_entity
    end
  end

  #deletar Filme
  def destroy
    Movie.find(params[:id]).destroy
    head :no_content
  end

  def movie_params
    params.require(:movie).permit(:title, :description)
  end

end
