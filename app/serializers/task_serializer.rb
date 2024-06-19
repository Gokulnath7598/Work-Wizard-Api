class TaskSerializer < ActiveModel::Serializer
    attributes :id, :user_id, :project, :task_description, :status, :effort

    def project
        ProjectSerializer.new(object.project).attributes
    end

end