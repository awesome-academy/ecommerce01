class PagesController < ApplicationController
  def home
    @current_user = current_user if logged_in?
    fetch_products
  end

  def products; end

  def about; end

  def contact; end

  private

  def fetch_products
    @products = if params[:search]
                  Product.search(params[:search])
                         .order("created_at ASC")
                         .paginate(page: params[:page], per_page: 5)
                else
                  Product.order("created_at ASC")
                         .paginate(page: params[:page], per_page: 5)
                end
  end
end
