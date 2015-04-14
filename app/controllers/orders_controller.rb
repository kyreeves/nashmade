class OrdersController < ApplicationController
  before_action :authenticate_user!

  def sales
    @orders = Order.all.where(seller: current_user).order(created_at: :desc)
  end

  def purchases
    @orders = Order.all.where(buyer: current_user).order(created_at: :desc)
  end

  def new
    @order = Order.new
    @product = Product.find(params[:product_id])
  end

  def create
    @order = Order.new(order_params)
    @product = Product.find(params[:product_id])
    @seller = @product.user

    @order.product_id = @product.id
    @order.buyer_id = current_user.id
    @order.seller_id = @seller.id

    if @order.save
      redirect_to root_url
    else
      render :new
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:address, :city, :state)
    end
end
