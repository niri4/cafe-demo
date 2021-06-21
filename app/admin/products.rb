ActiveAdmin.register Product do
  permit_params :title, :status, :vat, :quantity, :category_id, :description, :detail, :free, :price, :image
  form do |f|
    f.inputs do
      f.input :category
      f.input :title
      f.input :status
      f.input :vat
      f.input :quantity
      f.input :description
      f.input :detail
      f.input :free
      f.input :price
      f.input :image, as: :file
    end
    f.actions
  end
end
