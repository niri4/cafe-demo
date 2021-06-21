ActiveAdmin.register Discount do
  permit_params :title, :value, product_ids: []

  form do |f|
    f.inputs do
      f.input :title
      f.input :product_ids, :label => 'Products', :as => :select, multiple: true, :collection => Product.all.map{|u| ["#{u.title}", u.id]}
      f.input :value
    end
    f.actions
  end
end
