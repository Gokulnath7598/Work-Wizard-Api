class Api::V1::User::DailyTasksController < ApplicationController

    before_action :authenticate_user

    def index
        if @current_user
          @daily_tasks = @current_user.daily_tasks.where(created_at: Date.today.beginning_of_day..Date.today.end_of_day)
          render json: @daily_tasks, each_serializer: DailyTaskSerializer, status: :ok
        end
    end

    def show
        if params[:id]
          @daily_tasks = DailyTask.find(id)
          render json: @daily_tasks, serializer: DailyTaskSerializer, status: :ok
        end
    end

    def create
        if @current_user
            @daily_task = @current_user.daily_task.create(daily_task_params)
            @daily_task.save
            render json: @daily_task, serializer: DailyTaskSerializer, status: :ok
        end
    end

    def update
        if params[:id]
            @daily_task = DailyTask.find(id)
            @daily_task.update(daily_task_params)
            @daily_task.save
            render json: @daily_task, serializer: DailyTaskSerializer, status: :ok
        end
    end

    def destroy
        if params[:id]
            @daily_task = DailyTask.find(id)
            unless @daily_task.destroy
                throw_error(@daily_task.error.full_messages, :unprocessible_entity)
            end  
        end
    end

    private
    def daily_task_params
      params.require(:daily_task).permit(:project_id, :task_desc)
    end

end