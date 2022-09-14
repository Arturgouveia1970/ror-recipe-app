class ShoppingListController < ApplicationController
  def index
    @shopping_list = Food.all
  end

  def destroy
    @shopping_list = Food.find(params[:id])
    @shopping_list.destroy
    flash[:success] = 'Item has been deleted successfully'
    redirect_to shopping_list
  end
end
