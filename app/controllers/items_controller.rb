class ItemsController < ApplicationController
    before_action :require_login
    before_action :admin_rights
    skip_before_action :admin_rights, only: [:index, :show]

    def index
        @user = User.find(session[:user_id])
        @items = Item.all
        @categories = Category.all
    end

    def new
        @item = Item.new
        @categories = Category.all
    end 

    def create
        @item = Item.new(item_params)
        if @item.save
            redirect_to item_path(@item.id)
        else 
            render :new
        end 
    end 

    def show
        @user = User.find(session[:user_id])
        @item = Item.find(params[:id])
        @comments = @item.comments
    end 

    def edit
        @item = Item.find(params[:id])        
    end

    def update
        @item = Item.find(params[:id])
        if @item.update(item_params)
            redirect_to item_path(@item)
        else 
            render :edit
        end
    end 

    def destroy
        @item = Item.find(params[:id])
        @item.destroy
        redirect_to items_path, notice: "You deleted the item: #{@item.name}"
    end

    def test
        item = Item.find(params[:id])
        user = User.find(session[:user_id])
        purchase = PurchasedItem.new(user_id: user.id, item_id: item.id)
        purchase.save
        redirect_to user_path(user)
    end

    private

    def item_params
        params.require(:item).permit(:name, :description, :price, :points, :category_name)
    end

    def require_login
        redirect_to '/', notice: "Please sign in first" unless session.include? :user_id
    end

    def admin_rights
        @user = User.find(session[:user_id])
        redirect_to user_path(@user.id), notice: "You do not have admin rights for that action" unless @user.admin
    end

end
