class Import::ImportSerializer < ActiveModel::Serializer
    attributes :movie, :category
  
    def movie
      object.as_json(only: [:id, :title])
    end

    def category
      object.category.as_json(only: [:id, :name])
    end
   
end