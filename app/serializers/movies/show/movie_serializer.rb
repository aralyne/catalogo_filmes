class Movies::Show::MovieSerializer < ActiveModel::Serializer
    attributes :message,  :movie
  
    def movie
      object.as_json(only: [:id, :title, :description, :created_at])
    end
  
    def message
      "Lançamentos"
    end
  
    belongs_to :category, serializer: Movies::Show::CategorySerializer

  end
  