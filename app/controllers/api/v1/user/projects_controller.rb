class Api::V1::User::ProjectsController < ApplicationController
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
    
  end
    