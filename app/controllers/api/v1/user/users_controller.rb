class Api::V1::User::UsersController < ApplicationController
    before_action :authenticate_user, only: [:show]
    
    def index
      if @current_user
        render json: @current_user, serializer: UserProfileSerializer, status: :ok
      end
    end

    # def create
    #   @user = User.new(user_params)
    #   if @user.save
    #       render json: @user, serializer: UserSerializer, status: :created
    #   else
    #     throw_error(@user.error.full_messages, :unprocessible_entity)    
    #   end  
    # end
  
    def update
      if @current_user
        if @current_user.update(user_params)
          update_user_projects(@user, user_params[:working_project_ids])
          render json: @current_user, serializer: UserProfileSerializer,  status: :ok
        else
          throw_error(@user.error.full_messages, :unprocessible_entity)
        end
      end    
    end
    
    private
    def user_params
      params.require(:user).permit(:name, :email, working_project_ids: [], working_hours: [:start_time, :end_time])
    end

    def update_user_projects(user, project_ids)
      project_ids.each do |project_id|
        user.user_projects.find_or_create_by(project_id: project_id)
      end
    end
  end
    