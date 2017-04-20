class ProductsController < ApplicationController

  # for rendering
  def index
    @products = Product.all
  end

  #for rendering
  def new
    @product = Product.new
  end

  def update
    @product = Product.find(params[:id])
    # TODO available_inventory cant be a negative
    if @product.update(product_params)
      redirect_to products_path
    else
      redirect_to products_path
    end
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path
    else
      render 'new'
    end
  end


  # ====== PRIVATE =======
  private
    def product_params
      params.require(:product).permit(:title, :price, :available_inventory)
    end
end
