class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:seller, :new, :create, :edit, :update, :destroy]
  before_action :validate_user, only: [:edit, :update, :destroy]


  def seller
    @products = Product.where(user: current_user).order("created_at DESC")
  end

  def index
    @products = Product.all.order("created_at DESC")
  end

  def show
  end


  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id

    if @product.save
      redirect_to @product
    else
      render :new
    end
  end

  def update
    @product.update(product_params)
  end

  def destroy
    @product.destroy
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :image)
    end

    def validate_user
      if current_user != @product.user
        redirect_to root_url
      end
    end
end
