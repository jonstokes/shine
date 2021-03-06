module Shine
  class User < ActiveRecord::Base
    include Shine::Concerns::AssetMountable

    has_many :assets

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable


    validates :email,              presence: true
    validates :encrypted_password, presence: true
    validates :role,               presence: true, inclusion: { in: %w(admin editor writer) }
    validates :biography,          presence: true
    validates :name,               presence: true

    mount_asset :profile_photo

    def display_email
      self[:display_email] || self[:email]
    end

    def find_by_email(email_address)
      find_by(email: email_address) || find_by(display_email: email_address)
    end

    def posts
     Post.where("'#{id}' = ANY(user_ids)")
    end
  end
end
