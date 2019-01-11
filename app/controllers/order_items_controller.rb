class OrderItemsController < ApplicationController
  before_action :logged_in_user,
    only: [:create, :destroy, :add_quantity, :reduce_quantity]

  def create
    # Find associated product and current cart
    chosen_product = Product.find(params[:product_id])
    add_items_to_cart(chosen_product)
    respond_to do |format|
      if @order_item.save!
        format.html{redirect_back(fallback_location: @current_cart)}
        format.js
      else
        format.html{render :new, notice: "Error adding product to basket!" }
      end
    end
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy
    redirect_back(fallback_location: @current_cart)
  end

  def add_quantity
    @order_item = OrderItem.find(params[:id])
    @order_item.quantity += 1
    @order_item.save
    redirect_back(fallback_location: @current_cart)
  end

  def reduce_quantity
    @order_item = OrderItem.find(params[:id])
    if @order_item.quantity > 1
      @order_item.quantity -= 1
      @order_item.save
      redirect_back(fallback_location: @current_cart)
    elsif @order_item.quantity == 1
      destroy
    end
  end

  private

  def line_item_params
    params.require(:order_item).permit(:quantity, :product_id, :cart_id)
  end

  def add_items_to_cart chosen_product
    if @current_cart.products.include?(chosen_product)
      @order_item = @current_cart.order_items.find_by product_id: chosen_product
      @order_item.quantity += 1
    else
      @order_item = OrderItem.new
      @order_item.cart = @current_cart
      @order_item.product = chosen_product
      @order_item.quantity = 1
    end
  end
end
