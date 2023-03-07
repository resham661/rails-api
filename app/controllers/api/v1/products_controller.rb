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
      render json: { error: "Product not created.", status: "failed" }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(prod_params)
      render json: @product, status: 200
    else
      render json: { error: "Product not updated.", status: "failed" }, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroy
      render json: { data: "Product deleted successfully", status: 'success'}, status: :no_content 
    else
      render json: {data: "Something went wrong", status: 'failed'}
    end
  end

  private
    def set_product
      @product = Product.find_by(id: params[:id])
    end

    def prod_params
      params.require(:product).permit([:name, :brand, :price])
    end
end
