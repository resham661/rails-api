class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  def index
    @products = Product.all
    render json: @products, status: 200
  end

  def show
    if @product
      render json: @product, status: 200    
    else
      render json: {error: "Not Found"}
    end 
  end

  def create
    @product = Product.new(prod_params)
    if @product.save
      render json: @product, status: 200
    else
      render json: { error: "Product not created." }, status: :unprocessable_entity 
    end
  end

  def update
    
  end

  def destroy
  
  end

  private
    def set_product
      @product = Product.find_by(id: params[:id])
    end

    def prod_params
      params.require(:product).permit([:name, :brand, :price])
    end
end
