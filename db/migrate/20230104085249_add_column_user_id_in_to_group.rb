class AddColumnUserIdInToGroup < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :user_id, :bigint
  end
end
