module RingleMusic
    class Base < Grape::API

        mount RingleMusic::V1::MusicApi
        mount RingleMusic::V1::UserApi
        mount RingleMusic::V1::GroupApi
        
    end
end