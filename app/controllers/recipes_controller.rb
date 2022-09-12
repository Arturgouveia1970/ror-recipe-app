class RecipesController < ApplicationController
  def index; end

  def public; end

  def new
    @user = current_user
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to root_path, notice: 'Recipe added successfully!'
    else
      render :show
    end
  end

  def show
    @recipe = Recipe.includes([:user]).find(params[:id])
  end
end