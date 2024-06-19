class Api::V1::Admin::UsersController < ApplicationController
    # before_action :authenticate_user, only: [:show]
    
    def index
      @users = User.all
      render json: @users, each_serializer: UserTaskSerializer
    end
  
    # def create
    #   @user = User.new(user_params)
    #   if @user.save
    #       render json: @user, serializer: UserSerializer, status: :created
    #   else
    #     throw_error(@user.error.full_messages, :unprocessible_entity)    
    #   end  
    # end
  
    # def update
    #   if @user.update(user_params)
    #     render json: @user, serializer: UserSerializer,  status: :ok
    #   else
    #     throw_error(@user.error.full_messages, :unprocessible_entity)
    #   end    
    # end
    
    private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :user_auth_id)
    end

  end
    