class ItemsController < ApplicationController

    def index
        @items = Item.all
    end

    def new
        @item = Item.new
        @categories = Category.all
    end 

    def create
        # validate for repeated items
        @item = Item.new(item_params)
       


    end 


    private

    def item_params
        params.require(:item).permit(:name, :description, :price, :points, :category_id)
    end

end
