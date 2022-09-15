class InventoryController < ApplicationController
  def index
    @inventories = current_user.inventories.includes(:user).all
  end

  def show
    @inventory = current_user.inventories.includes(:user).find(params[:id])
    @inventory_food = @inventory.inventory_foods.includes(:food)
  end

  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = Inventory.new(inventory_params)
    @inventory.user = current_user
    if @inventory.save
      flash[:success] = 'New inventory has been created !!'
      redirect_to user_inventories_path
    else
      flash['alert'] = 'Inventory could not created !!'
      render :new
    end
  end

  def destroy
    @inventory = Inventory.find(params[:id])
    @inventory.destroy
    flash[:success] = 'Inventory has been deleted successfully'
    redirect_to user_inventories_path
  end

  private

  def inventory_params
    params.require(:inventory).permit(:name)
  end
end
