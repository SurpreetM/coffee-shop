class Item < ApplicationRecord
    belongs_to :category
    has_many :purchased_items
    has_many :users, through: :purchased_items
    has_many :comments
    has_many :users, through: :comments 

    def category_name=(name)
        self.category = Category.find_or_create_by(name: name)
    end
    
    def category_name
        self.category ? self.category.name : nil
    end
    
end
