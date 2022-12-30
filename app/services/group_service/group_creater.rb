module GroupService
    class GroupCreater < ApplicationService
        def initialize(args)
            @group_name = args[:group_name]
        end

        def call
            begin
                Group.create!(group_name: @group_name)
                return {success: true}
            rescue => e
                return {success: false, message: e.message}
            end
        end
    end
end