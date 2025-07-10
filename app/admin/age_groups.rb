ActiveAdmin.register AgeGroup do
    permit_params :name, :min_age, :max_age
  
    index do
      selectable_column
      id_column
      column :name
      column :min_age
      column :max_age
      actions
    end
  
    form do |f|
      f.inputs do
        f.input :name
        f.input :min_age
        f.input :max_age
      end
      f.actions
    end
  end