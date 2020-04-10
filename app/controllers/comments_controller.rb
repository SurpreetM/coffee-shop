class CommentsController < ApplicationController

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

    private 

    def comment_params
        params.require(:comment).permit(:rating, :decription, :user_id, :item_id)
    end

end
