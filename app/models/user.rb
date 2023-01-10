class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  validates :user_name, uniqueness: { message: "user_name must be unique"}

  has_many :user_musics
  has_many :user_likes_musics
  has_many :group_musics
  has_many :group_users

  has_many :groups, through: :group_users

  def change_name!(user_name:)
    begin
      self.update!(user_name: user_name)
      true
    rescue => e
      false
    end
  end

  def change_password!(password:)
    return false if password == "" || self.valid_password?(password)
    begin
      self.update(password: password)
      true
    rescue
      false
    end
  end

  def self.create_jwt_token(user_id)
    payload = {
      user_id: user_id,
      exp_date: (Time.now + 5.hours).to_i
    }
    token = JWT.encode(payload, SOME_SECRET_KEY, 'HS256')
    return token
  end

  def self.validate_jwt_token(jwt_token)
    begin
      decoded = JWT.decode(jwt_token, SOME_SECRET_KEY, true, algorithm: 'HS256')
    rescue => e
      return nil
    end

    user_id = decoded[0]["user_id"]

    return nil if decoded[0]["exp_date"] < Time.now.to_i

    # If the signature is valid, return the payload as a hash
    return User.find_by(id: user_id)

  end


end
