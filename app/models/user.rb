class User < ApplicationRecord
    has_many :purchased_items
    has_many :items, through: :purchased_items
    has_many :comments 
    has_many :items, through: :comments 

    has_secure_password

    validates :name, presence: true
    validates :email, uniqueness: true, presence: true
    validates :balance, numericality: { only_integer: true }

    scope :commented, -> (num) { joins(:comments).where('user_id > ?', num)}
    scope :purchased, -> (num) { joins(:purchased_items).where('user_id > ?', num)}
    
end
