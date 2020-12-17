class UsersController < ApplicationController
  #listar todos os usuários
  def index
      users = User.all
      if users.empty?
        render json: {message: "Empty list"}, status: :ok
      else
        render json: users, status: :ok
      end
  end

  #listar usuário passando ID
  def show
      user = User.find(params[:id])
      if user.nil?
          render json: {message: "user not found"}, status: :ok
      else
          render json: user, status: :ok
      end
  end
  #Criar usuário 
  def create
    user = User.new(user_params)
    if user.save
        render json: user, status: :created
    else
        render json: {message:'User not saved'}, status: :unprocessable_entity
    end
end

  def user_params
    params.require(:user).permit(:name, :email)
  end

  #alterar usuário
  def update
    user = User.find(params[:id])
    if user.update(user_params)
        head :no_content
    else
        render json: {message:'User not updated'}, status: :unprocessable_entity

    end
  end

end
