class HomeController < ApplicationController
  def index
    @products = Product.active
    @products = @products.where(category_id: params[:category]) if params[:category].present?
  end
end
