class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all

  end
  def show
    @recipe = Recipe.find(params[:id])
    # @ingredients = @recipe.ingredients, trying to ingredients from @recipe and turn into an array.
  end
  def new
    @recipe = Recipe.new
  end
  def create
    @recipe = Recipe.create!(recipe_params)
    redirect_to recipe_path(@recipe)
  end
  def edit
    @recipe = Recipe.find(params[:id])
  end
  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    redirect_to recipe_path(@recipe)
  end
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to root_path
  end
private
def recipe_params
  params.require(:recipe).permit(:title, :directions, :ingredients, :photo_url, :notes)
end

end
