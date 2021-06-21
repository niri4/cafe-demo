class LineItemsController < ApplicationController
  def update
    line_item = LineItem.find(params[:id])
    order = line_item.order
    if line_item.update(line_item_params)
      order.modify
      render json: { data: line_item, order: order }, ststus: :ok
    else
      render json: { error: line_item.errors }, ststus: :unprocessible_entity
    end

  end

  private

  def line_item_params
    params.require(:line_item).permit(:quantity)
  end
end
