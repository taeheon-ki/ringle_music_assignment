class ChangeUserGroupsNullConstraint < ActiveRecord::Migration[6.1]
  def change
    change_column_null :user_groups, :group_id, false
    change_column_null :user_groups, :user_id, false
  end
end
