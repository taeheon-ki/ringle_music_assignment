class UserGroup < ApplicationRecord
  belongs_to :group
  belongs_to :user
  validate :unique_membership



  def unique_membership
    if UserGroup.where(group: group, user: user).exists?
      errors.add(:base, "User is already a member of this group")
    end
  end
end
