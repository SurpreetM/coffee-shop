class UsersController < ApplicationController

    def new
        @user = User.new
    end 

    def create
        @user = User.new(user_params)
        @user.save
        session[:user_id] = @user.id
        redirect_to user_path(@user.id)
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
        @user.update(user_params)
        redirect_to user_path(@user)
    end 


    private

    def user_params
        params.require(:user).permit(:name, :email, :balance, :admin, :password)
    end

end
