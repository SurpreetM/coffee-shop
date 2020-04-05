class ItemsController < ApplicationController

    def index
        @items = Item.all
        @categories = Category.all
    end

    def new
        @item = Item.new
        @categories = Category.all
    end 

    def create
        # validate for repeated items
        @item = Item.new(item_params)
        if @item.save
            redirect_to item_path(@item.id)
        else 
            render :new
        end 
    end 

    def show
        @item = Item.find(params[:id])
    end 


    private

    def item_params
        params.require(:item).permit(:name, :description, :price, :points, :category_name)
    end

end
