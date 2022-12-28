module RingleMusic
    class Base < Grape::API

        mount RingleMusic::V1::MusicApi
        
    end
end