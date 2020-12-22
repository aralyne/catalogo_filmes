class MoviesController < ApplicationController
  #skip_before_action :authenticate_user!, only: :index
  #listar todos os usuários
  def index
    movies = Movie.all
    if movies.empty?
      render json: {message: "Empty list"}, status: :ok
    else
      render json: movies, status: :ok, each_serializer: Movies::Index::MovieSerializer 
    end
  end

  #listar Filme passando ID
  def show
    movie = Movie.find(params[:id])
    if movie.nil?
      render json: {message: "movie not found"}, status: :ok
    else
      render json: movie, status: :ok, serializer: Movies::Show::MovieSerializer
    end
  end

  #Criar Filme 
  def create
    movie = Movie.new(movie_params)
   
    if movie.save
        render json: movie, status: :created
    else
        render json: {errors: movie.errors}, status: :unprocessable_entity
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
    params.require(:movie).permit(:title, :description, :category_id)
  end

end
