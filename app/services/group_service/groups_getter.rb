module GroupService
    class GroupsGetter < ApplicationService
        def initialize()
        end

        def call
            groups = Group.all
            groups = groups.as_json(only:[:id, :group_name])
        end
    end
end