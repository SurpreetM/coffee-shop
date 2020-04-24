class UsersController < ApplicationController

    def index
        @user = User.find(session[:user_id])
        redirect_to user_path(@user.id), notice: "You do not have admin rights for that action" unless @user.admin

        @users_purchases = User.joins(:purchased_items).group("user_id").order("count(user_id) DESC")
        @users_comments = User.joins(:comments).group("user_id").order("count(user_id) DESC")
    end 

    def new
        @user = User.new
    end 

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user.id)
        else
            render :new
        end 
    end 

    def show
        user = User.find(params[:id])
        redirect_to '/', notice: "Forbidden action" unless session[:user_id] == user.id
        @user = user
    end 

    def edit
        user = User.find(params[:id])
        redirect_to '/', notice: "Forbidden action" unless session[:user_id] == user.id
        @user = user
    end 

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to user_path(@user)
        else 
            render :edit
        end 
    end 


    private

    def user_params
        params.require(:user).permit(:name, :email, :balance, :admin, :password)
    end

    

end
