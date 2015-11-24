module Shine
  class User < ActiveRecord::Base
    has_many :assets

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable, :confirmable,
           :recoverable, :rememberable, :trackable, :validatable


    validates :email,              presence: true
    validates :encrypted_password, presence: true
    validates :role,               presence: true, inclusion: { in: %w(admin editor writer) }
    validates :biography,          presence: true
    validates :name,               presence: true
    
    def posts
     Post.where("'#{id}' = ANY(user_ids)")
    end
  end
end
