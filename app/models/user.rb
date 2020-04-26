class User < ApplicationRecord
    has_many :purchased_items
    has_many :items, through: :purchased_items
    has_many :comments 
    has_many :items, through: :comments 

    has_secure_password

    validates :name, presence: true
    validates :email, uniqueness: true, presence: true
    validates :balance, numericality: { only_integer: true }

    def self.create_with_omniauth(auth)
        user = find_or_create_by(uid: auth['uid'], provider: auth['provider'])
        user.email = "#{auth['uid']}@#{auth['provider']}.com"
        user.password = auth['uid']
        user.name = auth['info']['name']
        user.balance = 1
        return user
    end
    
end
