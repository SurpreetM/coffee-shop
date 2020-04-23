class UsersController < ApplicationController

    def index
        users_with_purchases = User.purchased(0)
        @users_with_purchases = users_with_purchases.uniq

        users_with_comments = User.commented(0)
        @users_with_comments = users_with_comments.uniq
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
