class Item < ApplicationRecord
    belongs_to :category
    has_many :purchased_items
    has_many :users, through: :purchased_items
    has_many :comments
    has_many :users, through: :comments 

    validates :name, presence: true
    validates :name, uniqueness: true
    validates :description, presence: true
    validates :category_name, presence: true
    validates :price, numericality: { only_integer: true }

    def category_name=(name)
        self.category = Category.find_or_create_by(name: name)
    end
    
    def category_name
        self.category ? self.category.name : nil
    end

    def comments_count
        comments.count
    end 

    def average_rating
        if comments.count > 0
            total = 0 
            comments.each do |c|
            total += c.rating 
            end 
            total / comments_count
        else
            0 
        end 
    end

end
