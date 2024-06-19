class AddColumnUserAuthIdToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :user_auth_id, :string
  end
end
