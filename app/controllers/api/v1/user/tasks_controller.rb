class Api::V1::User::TasksController < ApplicationController

    before_action :authenticate_user, only: [:index, :create]

    def index
        if @current_user
          @tasks = @current_user.tasks.where(created_at: Date.today.beginning_of_day..Date.today.end_of_day)
          render json: @tasks, each_serializer: TaskSerializer, status: :ok
        end
    end

    def show
        if params[:id]
          @task = Task.find(id)
          render json: @task, serializer: TaskSerializer, status: :ok
        end
    end

    def create
        if @current_user
            @task = @current_user.task.create(task_params)
            @task.save
            render json: @task, serializer: TaskSerializer, status: :ok
        end
    end

    def update
        if params[:id]
            @task = Task.find(id)
            @task.update(task_params)
            @task.save
            render json: @task, serializer: TaskSerializer, status: :ok
        end
    end

    private
    def task_params
      params.require(:task).permit(:project_id, :task_description, :status, :effort)
    end

end