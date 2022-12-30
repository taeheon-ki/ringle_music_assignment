class UserGroup < ApplicationRecord
  belongs_to :group
  belongs_to :user
  validate :unique_membership

  def as_json_of_group()
    {
      group_id: group.id,
      group_name: group.group_name,
    }
  end

  def unique_membership
    if UserGroup.where(group: group, user: user).exists?
      errors.add(:base, "User is already a member of this group")
    end
  end
end
