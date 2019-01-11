class CategoriesController < ApplicationController
  def show
    @category = Categories.find(params[:id])
    @product = @category.product.all
  end
end
