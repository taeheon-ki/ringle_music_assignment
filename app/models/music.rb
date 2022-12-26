class Music < ApplicationRecord
    has_many :likes, :dependent => :delete_all
    has_many :likers, through: :likes, source: :user
end
