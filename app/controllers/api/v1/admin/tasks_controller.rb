class Api::V1::Admin::TasksController < ApplicationController

    def index
        if params[:start_date].present? && params[:end_date].present?
            start_date = parse_date(params[:start_date])
            end_date = parse_date(params[:end_date])
        else
            start_date = Date.current.beginning_of_month
            end_date = Date.current.end_of_month
        end
        @tasks = Task.where(created_at: start_date.beginning_of_day..end_date.end_of_day)
        if params[:user_id].present?
            user = User.find(params[:user_id])
            @tasks = @tasks.where(user_id: params[:user_id])
        end
        if params[:project_id].present?
          project = Project.find(params[:project_id])
          @tasks = @tasks.where(project_id: params[:project_id])
        end
        render json: @tasks, each_serializer: TaskSerializer, status: :ok
    end

    def show
        if params[:id]
          @task = Task.find(id)
          render json: @task, serializer: TaskSerializer, status: :ok
        end
    end

    # def create
    #     if @current_user
    #         @task = @current_user.task.create(task_params)
    #         @task.save
    #         render json: @task, serializer: TaskSerializer, status: :ok
    #     end
    # end

    # def update
    #     if params[:id]
    #         @task = Task.find(id)
    #         @task.update(task_params)
    #         @task.save
    #         render json: @task, serializer: TaskSerializer, status: :ok
    #     end
    # end

    private
    # def task_params
    #   params.require(:task).permit(:project_id, :task_description, :status, :effort)
    # end

    def parse_date(date_str)
        Date.strptime(date_str, '%d:%m:%Y') rescue nil
    end

end