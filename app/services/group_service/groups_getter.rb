module GroupService
    class GroupsGetter < ApplicationService
        def initialize()
        end

        def call
            groups = Group.all

        end
    end
end