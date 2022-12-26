module RingleMusic
    class Base < Grape::API

        mount RingleMusic::V1::Musics
        
    end
end