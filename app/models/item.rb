class Item < ApplicationRecord
    belongs_to :category
    has_many :purchased_items
    has_many :users, through: :purchased_items
    has_many :comments
    has_many :users, through: :comments 
end
