class InventoryFoodController < ApplicationController
  def show
    @current_inventory = Inventory.find(params[:inventory_id])
    @food_list = Food.where(user_id: current_user.id)
    @inventory_food_list = InventoryFood.where(inventory_id: params[:inventory_id])
  end

  def new
    @inventory = current_user.inventories.includes(:user).find(params[:id])
    @inventory_food = InventoryFood.new
    @params = params
  end

  def create
    food_list = params[:inventory_food][:food_list]
    food_list = food_list.drop(1)
    food_list.each do |food|
      next unless InventoryFood.where(food_id: food.to_i, inventory_id: params[:id]).blank?

      new_inventory_food = InventoryFood.new(food_id: food.to_i, quantity: params[:inventory_food][:quantity],
                                             inventory_id: params[:id])
      new_inventory_food.save
    end
    redirect_to user_inventory_path(params[:id])
  end

  def destroy
    @inventory_food = InventoryFood.find(params[:id])
    @inventory_food.destroy
    flash[:success] = 'Inventory Food has been deleted successfully'
    redirect_to user_inventory_path
  end

  private

  def inventory_foods_params
    params.require(:inventory_foods).permit(:food_list, :quantity)
  end
end
