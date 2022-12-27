module Entities
    module V1
      class UserEntity < RootEntity
        expose :title, :artist, :album
      end
    end
  end