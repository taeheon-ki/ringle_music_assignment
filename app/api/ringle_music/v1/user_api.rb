module RingleMusic
    module V1
        class UserApi < Grape::API
            version 'v1', using: :path
            format :json
            prefix :api

            resource :users do

                

                get "playlist" do
                    user = jwt token으로 validate
                    playlists = UserPlaylistMusic.where(user: user)

                end
            
                params do 
                    requires :user_name, type: String
                    requires :email, type: String 
                    requires :password, type: String
                end
                post "signup" do
                    user = User.find_by(email: params[:email])
                    if user 
                        return {
                            success: false,
                            message: "User Email Not Usable"
                        }
                    end
                    
                    user = User.create!({
                        user_name: params[:user_name],
                        email: params[:email],
                        password: params[:password]	
                    })
                    
                    
                
                    return {
                        success: true,
                        user: user,
                    }
                end

                params do
                    requires :email, type: String
                    requires :password, type: String
                end
                post "signin" do
                    user = User.find_by(email: params[:email])
                    if user.nil?
                        return {
                          success: false,
                          message: "User not found",
                        }
                      end
                    is_valid = user.valid_password?(params[:password])
                    unless is_valid
                        return {
                            success: false,
                            message: "not valid",
                        }
                    end

                    jwt_token = User.create_jwt_token(user.id)

                    return {
                        success: true,
                        message: "valid",
                        jwt_token: jwt_token,
                    }
                end
            end
        end
    end
end