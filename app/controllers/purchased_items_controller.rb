class PurchasedItemsController < ApplicationController
    def new
        @purchased = PurchasedItem.new
        @item = Item.find(params[:item_id])
    end

    def create
        @purchased = PurchasedItem.new(purchased_params)
        user = User.find(session[:user_id])
        @purchased.user_id = user.id
        if @purchased.save
            redirect_to user_path(user.id), notice: "Thank you for your purchase #{user.name}!"
        else 
            render new_item_purchased_item_path(@item.id)
        end
    end 



    private

    def purchased_params
        params.require(:purchased_item).permit(:user_id, :item_id)
    end

end

