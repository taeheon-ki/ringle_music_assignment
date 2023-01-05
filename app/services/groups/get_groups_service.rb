module Groups
    class GetGroupsService < ApplicationService
        def initialize()
        end

        def call
            groups = Group.all

        end
    end
end