class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]

  has_many :cars, dependent: :destroy
  has_many :bookings, dependent: :destroy

  has_attachment :user_image


  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    fb_names =  auth.info.slice(:first_name, :last_name)
    our_name = { name: fb_names.values.join(" ") }
    user_params.merge! auth.info.slice(:email)
    user_params.merge! our_name
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.where(provider: auth.provider, uid: auth.uid).first
    user ||= User.where(email: auth.info.email).first # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user
  end
end
