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

    #criar novo usuário
    def create
        user = User.new(user_params)
        if user.save
            render json: {message:'Saved user'}, status: :ok
        else
            render json: {message:'User not saved'}, status: :unprocessable_entity
        end
    end

    #excluir usuário
    def destroy
        user = User.find(params[:id])
        user.destroy
        render json: {message:'Deleted user'}, status: :ok
    end

    #alterar usuário
    def update
        user = User.find(params[:id])
        if user.update_attributes(user_params)
            render json: {message:'Updated user'}, status: :ok
        else
            render json: {message:'User not update'}, status: :unprocessable_entity
    
        end
    end
end
