module RingleMusic
    class Base < Grape::API
        mount RingleMusic::V1::Musics
        mount RingleMusic::V1::Users
    end
end