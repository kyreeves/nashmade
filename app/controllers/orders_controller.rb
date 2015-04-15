class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:new, :create]

  def sales
    @orders = Order.where(seller: current_user).order(created_at: :desc)
  end

  def purchases
    @orders = Order.where(buyer: current_user).order(created_at: :desc)
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @seller = @product.user

    @order.product_id = @product.id
    @order.buyer_id = current_user.id
    @order.seller_id = @seller.id

    if @order.save
      flash[:notice] = 'Your Order Was Successful!'
      redirect_to root_url
    else
      render :new
    end
  end

  private

    def set_product
      @product = Product.find(params[:product_id])
    end

    def order_params
      params.require(:order).permit(:address, :city, :state)
    end
end
