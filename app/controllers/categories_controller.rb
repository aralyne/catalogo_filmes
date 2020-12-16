class CategoriesController < ApplicationController
    def index
        categories = Category.all
        if categories.empty?
          render json: {message: "Empty list"}, status: :ok
        else
          render json: categories, status: :ok
        end
    end
end
