class RenameGroupUserToUserGroup < ActiveRecord::Migration[6.1]
  def change
    rename_table :group_users, :user_groups
  end
end
