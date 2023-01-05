class Group < ApplicationRecord
    validates :group_name, uniqueness: { message: "Groupname must be unique"}
    has_many :group_musics
    has_many :users

    def change_name!(group_name:)
        begin
            self.group_name = group_name
            self.save!
            true
        rescue => e
            false
        end
            
    end
end
