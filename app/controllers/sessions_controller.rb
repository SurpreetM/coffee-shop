class SessionsController < ApplicationController

    def new
        @users = User.all
    end 

    def create
        if auth
            @user = User.create_with_omniauth(auth)
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