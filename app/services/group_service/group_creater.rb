module GroupService
    class GroupCreater < ApplicationService
        def initialize(group_name)
            @group_name = group_name
        end

        def call

            Group.create!(group_name: @group_name)
            return {success: true, created_group: @group_name}

        end
    end
end