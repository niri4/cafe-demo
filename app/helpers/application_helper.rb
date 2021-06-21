module ApplicationHelper
	def categories
    Category.all
  end

  def cart_count
    current_customer.orders.where(status: "cart").first&.line_items&.count
  end
end
