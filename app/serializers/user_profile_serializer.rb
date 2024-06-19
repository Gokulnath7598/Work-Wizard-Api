class UserProfileSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :working_projects, :working_hours
  
    def name
      object.first_name + " " + object.last_name
    end

    def working_projects
        object.projects.map do |project|
          {
            id: project.id,
            name: project.name
          }
        end
    end

    def working_hours
        {
          start_time: object.start_time.strftime("%I:%M %p"),
          end_time: object.end_time.strftime("%I:%M %p")
        }
    end

end 