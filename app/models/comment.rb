class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :item

    validates :rating, presence: true, numericality: { only_integer: true }
end
