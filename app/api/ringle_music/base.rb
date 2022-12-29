module RingleMusic
    class Base < Grape::API

        mount RingleMusic::V1::MusicApi
        mount RingleMusic::V1::UserApi
        
    end
end