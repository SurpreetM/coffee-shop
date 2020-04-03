class ItemsController < ApplicationController

    def index
        @items = Item.all
    end

    def new
        @item = Item.new
        @categories = Category.all
    end 


    private

    

end
