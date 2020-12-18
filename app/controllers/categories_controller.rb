class CategoriesController < ApplicationController
  def index
      categories = Category.all
      if categories.empty?
        render json: {message: "Empty list"}, status: :ok
      else
        render json: categories, status: :ok
      end
  end  
    #listar categoria passando ID
  def show
    category = Category.find(params[:id])
    if category.nil?
        render json: {message: "category not found"}, status: :ok
    else
        render json: category, status: :ok
    end
  end
  #Criar categoria 
  def create
    category = Category.new(category_params)
    if category.save
        render json: category, status: :created
    else
        render json: {errors: category.errors}, status: :unprocessable_entity
    end
  end

  #alterar categoria
  def update
    category = Category.find(params[:id])
    if category.update(category_params)
        head :no_content
    else
        render json: {errors: category.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    head :no_content
  end

  def category_params
    params.require(:category).permit(:name)
  end  
  
end     


