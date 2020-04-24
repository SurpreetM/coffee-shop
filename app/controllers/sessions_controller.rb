class SessionsController < ApplicationController

    def new
        @users = User.all
    end 

    def create
        if  request.env['omniauth.auth']
            @user = User.find_or_create_by(uid: request.env['omniauth.auth']['uid']) do |u|
            u.name = auth['info']['name']
            u.email = auth['info']['email']
            end 
            session[:user_id] = @user.id
            redirect_to user_path(@user.id)
        else
            user = User.find_by(id: params[:user_id])
            @user = user.try(:authenticate, params[:password])
            session[:user_id] = @user.id
            redirect_to user_path(@user.id)  
            if !@user 
                redirect_to '/signin' , notice: "Incorrect Password"
            end 
        end       
    end

    def destroy
        session.delete :user_id
        redirect_to '/'
    end 

    private

    def auth
        request.env['omniauth.auth']
    end

end