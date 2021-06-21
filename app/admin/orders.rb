ActiveAdmin.register Order do
  permit_params :status

  form do |f|
    f.inputs do
      f.input :status
    end
    f.actions
  end
end
