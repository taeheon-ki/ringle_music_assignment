class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  validates :user_name, uniqueness: { message: "Groupname must be unique"}

  has_many :user_playlist_musics
  has_many :user_likes_musics
  has_many :group_playlist_musics
  has_many :group_users

  has_many :groups, through: :group_users

  def self.create_jwt_token(user_id)
    payload = {
      user_id: user_id,
      exp_date: Time.new.to_i + 10.hours
    }
    token = JWT.encode(payload, SOME_SECRET_KEY, 'HS256')
    return token
  end

  def self.validate_jwt_token(jwt_token)
    decoded = JWT.decode(jwt_token, SOME_SECRET_KEY, true, algorithm: 'HS256')
    puts decoded

    # Check that the signature is valid
    if JWT.decode(jwt_token, SOME_SECRET_KEY, false, algorithm: 'HS256') == decoded
      # If the signature is valid, return the payload as a hash
      return decoded[0].with_indifferent_access
    else
      # If the signature is not valid, return an empty hash
      return {}
    end
  end


end
