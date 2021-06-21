ActiveAdmin.register Customer do
   permit_params :first_name, :last_name, :email, :password, :password_confirmation, :funds

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :funds
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
