class Categories::Index::CategorySerializer < ActiveModel::Serializer
    attributes :category, :message
  
    def category
      object.as_json(only: [:id, :name])
    end

    def message
    "Todas Categorias"
    end
   
end