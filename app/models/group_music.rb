class GroupMusic < ApplicationRecord
  belongs_to :group
  belongs_to :music
  belongs_to :user




end
