class Users::Create::UserSerializer < ActiveModel::Serializer
    attributes :user
  
    def user
      object.as_json(only: [:id, :name, :email])
    end
  
  end