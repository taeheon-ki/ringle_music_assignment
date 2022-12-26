module RingleMusic
    class Base < Grape::API
        mount RingleMusic::V1::Users
        mount RingleMusic::V1::Groups
        mount RingleMusic::V1::Playlists
        mount RingleMusic::V1::Musics
    end
end