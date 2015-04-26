class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:seller, :new, :create, :destroy, :edit, :update]
  before_action :validate_user, only: [:destroy, :edit, :update]

  def seller
    @products = Product.where(user: current_user).order(created_at: :desc)
  end

  def index
    @products = Product.all.order(created_at: :desc)
    @categories = Category.all
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
      flash[:notice] = 'You have successfully created a product!'
      redirect_to @product
    else
      flash[:alert] = 'Something went wrong'
      render :new
    end
  end

  def update
    if @product.update(product_params)
      flash[:notice] = 'You have successfully updated this product!'
      redirect_to @product
    else
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:notice] = 'Product has been deleted'
      redirect_to root_path
    else
      render :show
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :image, :category_id)
    end

    def validate_user
      if current_user != @product.user && current_user.role != "admin"
        redirect_to root_url
      end
    end
end
