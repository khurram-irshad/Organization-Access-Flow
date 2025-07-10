ActiveAdmin.register Organization do
    permit_params :name, :description
  
    index do
      selectable_column
      id_column
      column :name
      column :description
      column :user_count do |org|
        org.users.count
      end
      actions
    end
  
    form do |f|
      f.inputs do
        f.input :name
        f.input :description
      end
      f.actions
    end
  end