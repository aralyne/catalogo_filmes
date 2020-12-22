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
      render json: user, status: :ok
  end
  #Criar usuário 
  def create
    user = User.new(user_params)
    if user.save
        render json: user, status: :created
    else
        render json: {errors: user.errors}, status: :unprocessable_entity
    end
  end

  #alterar usuário
  def update
    user = User.find(params[:id])
    if user.update(user_params)
        head :no_content
    else
        render json: {errors: user.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:id]).destroy
    head :no_content
  end

  def user_params
    params.require(:user).permit(:name, :email,:password)
  end

end
