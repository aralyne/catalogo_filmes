class ApiMoviesController < ApplicationController
  def import
    adapter = Omdb::Movie.new(api_movies_params).call
    categories = adapter[:categories].map{|c| Category.find_or_create_by(name: c)}
    movie = Movie.create(
      user_id: current_user.id, 
      title: adapter[:title],
      description: adapter[:description], 
      category_id: categories.last.id 
    )
    
    render json: movie, status: :created, serializer: Import::ImportSerializer
  end

  def api_movies_params #filme que vem da API externa
    params.require(:movie).permit(:title)
  end
end