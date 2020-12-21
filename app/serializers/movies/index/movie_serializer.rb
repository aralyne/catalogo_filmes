class Movies::Index::MovieSerializer < ActiveModel::Serializer
  attributes :message,  :movie, :category

  def category
    object.category.as_json(only: [:id, :name])
  end

  def movie
    object.as_json(only: [:id, :title, :description])
  end

  def message
    "Lançamentos"
  end

end
