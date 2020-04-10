class CommentsController < ApplicationController
    before_action :require_login

    def index
        @comments = Comment.all
    end

    def new
        @comment = Comment.new
    end

    def create
        @comment = Comment.new(comment_params)
        user = User.find(session[:user_id])
        @comment.user_id = user.id
        if @comment.save
            redirect_to item_path(@comment.item.id), notice: "Thank you for your feedback #{user.name}!"
        else 
            render :new
        end
    end 

    def edit
        @comment = Comment.find(params[:id])
    end

    def update
        user = User.find(session[:user_id])
        @comment = Comment.find(params[:id])
        if @comment.update(comment_params)
            redirect_to item_path(@comment.item.id), notice: "Thank you for your feedback #{user.name}!"
        else 
            render :edit
        end
    end 

    def destroy
        user = User.find(session[:user_id])
        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_to user_path(user.id), notice: "You deleted your feedback for our #{@comment.item.name}"
    end 

    private 

    def comment_params
        params.require(:comment).permit(:rating, :decription, :user_id, :item_id)
    end

    def require_login
        redirect_to '/', notice: "Please sign in first" unless session.include? :user_id
    end

end
