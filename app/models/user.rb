class User < ApplicationRecord
    has_many :purchased_items
    has_many :items, through: :purchased_items
    has_many :comments 
    has_many :items, through: :comments 

    has_secure_password

    validates :name, presence: true
    validates :email, uniqueness: true
    
end
