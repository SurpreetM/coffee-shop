class CommentsController < ApplicationController

    def index
        @comments = Comment.all
    end

    def new
        @item = Item.find(params[:item_id])
        @comment = Comment.new
    end

    def create
        @item = Item.find(params[:id])
        @comment = Comment.new(item_id: params[:item_id], decription: comment_params[:decription], rating: comment_params[:rating], user_id: 1)
        if @comment.save
            redirect_to comments_path
        else 
            @item = Item.find(params[:item_id])
            render :new
        end
    end 

    def comment_params
        params.require(:comment).permit(:rating, :decription, :user_id, :item_id)
    end

end
