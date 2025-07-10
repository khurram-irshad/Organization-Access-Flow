ActiveAdmin.register User do
  permit_params :email, :first_name, :last_name, :date_of_birth, :age_group_id, role_ids: []

  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :date_of_birth
    column :age_group do |user|
      user.age_group&.name
    end
    column :roles do |user|
      user.roles.map(&:name).join(", ")
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :date_of_birth, as: :date_picker
      f.input :age_group
      f.input :roles, as: :check_boxes, collection: Role.all
    end
    f.actions
  end
end