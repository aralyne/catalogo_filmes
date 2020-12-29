class Import::ImportSerializer < ActiveModel::Serializer
    attributes :movie
  
    def movie
      object.as_json(only: [:title])
    end
   
end