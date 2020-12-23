class Movies::Create::MovieSerializer < ActiveModel::Serializer
    attributes :movie, :category
  
    def category
      object.category.as_json(only: [:id, :name])
    end
  
    def movie
      object.as_json(only: [:id, :title, :description, :created_at])
    end
  
  end