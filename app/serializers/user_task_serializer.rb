class UserTaskSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :active_task, :completed_task, :last_update
  
    def name
      object.first_name + " " + object.last_name
    end

    def active_task
        start_date = Date.current.beginning_of_month
        end_date = Date.current.end_of_month
        object.tasks.where(status: 'active', created_at: start_date.beginning_of_day..end_date.end_of_day).count
    end

    def completed_task
        start_date = Date.current.beginning_of_month
        end_date = Date.current.end_of_month
        object.tasks.where(status: 'completed', created_at: start_date.beginning_of_day..end_date.end_of_day).count
    end

    def last_update
        object.tasks.last.updated_at
    end
end 