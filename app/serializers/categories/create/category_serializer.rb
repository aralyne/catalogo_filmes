class Categories::Create::CategorySerializer < ActiveModel::Serializer
    attributes :category
  
    def category
      object.as_json(only: [:id, :name])
    end
   
end