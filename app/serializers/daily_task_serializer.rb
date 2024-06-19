class DailyTaskSerializer < ActiveModel::Serializer
    attributes :id, :user_id, :project_id, :task_desc

end