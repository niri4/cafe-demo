class OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :find_order, except: [:new, :add_to_cart, :index]

  def index
    @orders = current_customer.orders.where.not(status: "cart")
  end

  def new
    @order = current_customer.orders.find_by(status: "cart")
    @discount_rate = @order.discount&.value
    @line_items = @order.line_items
  end

  def update
    if @order.placed
      redirect_to :root, notice: "Order placed"
    else
      redirect_to :root, errors: @order.errors
    end
  end
  
  def add_to_cart
    product = Product.find_by(id: params[:product_id])
    if product.present?
      create_or_update_order(product.id)
    end
    redirect_to :root
  end

  def destroy
   
   @order.destroy
   redirect_to :root
  end

  private

  def find_order
    @order = Order.find(params[:id])
  end

  def create_or_update_order product_id
    order = current_customer.orders.where(status: "cart").where("line_items.product_id = ?", product_id).first
    unless order.present?
      order = Order.find_or_initialize_by(status: "cart")
      line_item = order.line_items.new
      line_item.product_id = product_id
      line_item.quantity = 1
      line_item.customer = current_customer
      order.save
      order.modify
    end
  end
end
