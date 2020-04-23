class PurchasedItem < ApplicationRecord
    belongs_to :item 
    belongs_to :user

end
