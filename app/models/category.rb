class Category < ApplicationRecord
    has_many :items
    scope :longest_name, -> {order('LENGTH(name) desc').limit(1)}
end
