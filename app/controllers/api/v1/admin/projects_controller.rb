class Api::V1::Admin::ProjectsController < ApplicationController
    # before_action :authenticated?, only: [:show] # equivalent of authenticate_user!
    # before_action :set_user, only: [:show]
    
    def index
        @projects = Project.all
        # render json: @projects, each_serializer: ProjectSerializer, meta: pagination_dict(@projects)
        render json: @projects, each_serializer: ProjectSerializer
    end
          
    def show
      @project = Project.find(params[:id])
      render json: @project, serializer: ProjectSerializer, status: :ok
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
    # def set_user
    #   @user = User.find(params[:id])
    # end
    
  end
    