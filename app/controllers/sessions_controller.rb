class SessionsController < ApplicationController

    def new
        @users = User.all
    end 

    def create
        if auth
            @user = User.find_or_create_by(uid: auth['uid']) do |u|
                u.name = auth['info']['name']
                u.email = auth['info']['email']
            end 
            session[:user_id] = @user.id
            redirect_to user_path(@user.id)
        else 
            user = User.find_by(id: params[:user_id])
            if user.try(:authenticate, params[:password])
                @user = user
                session[:user_id] = @user.id
                redirect_to user_path(@user.id)  
                elsif !@user 
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