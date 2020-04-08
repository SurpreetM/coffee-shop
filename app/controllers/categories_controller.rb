class CategoriesController < ApplicationController

    #def new    
    #    @category = Category.new
    #end

    #def create
    #    @category = Category.new(category_params)
    #    @category.save
    #    redirect_to categories_path
    #end 

    #def index
    #    @categories = Category.all 
    #end

    def destroy
        @category = Category.find(params[:id])
        @category.destroy
        redirect_to items_path, notice: "You deleted the category: #{@category.name}"
    end 

    private

    def category_params
        params.require(:category).permit(:name)
    end

end
