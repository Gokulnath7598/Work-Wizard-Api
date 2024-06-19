class User < ApplicationRecord
    has_many :tasks
    has_many :daily_tasks

    has_many :user_projects
    has_many :projects, through: :user_projects
  
    accepts_nested_attributes_for :user_projects
  
    def working_hours=(hours)
      self.start_time = Time.parse(hours[:start_time])
      self.end_time = Time.parse(hours[:end_time])
    end
  
    def working_hours
      {
        start_time: start_time.strftime("%I:%M %p"),
        end_time: end_time.strftime("%I:%M %p")
      }
    end
  end
  
