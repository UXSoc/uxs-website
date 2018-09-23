ActiveAdmin.register User do
  permit_params :email, :role, :password, :password_confirmation

  index do
    selectable_column
    id_column

    column :email
    column :role
    column :created_at
    column :updated_at

    actions
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :role
      f.input :password
      f.input :password_confirmation
    end

    f.actions
  end

  action_item :set_editor, only: :show do
    unless user.editor?
      link_to "Set as Editor", set_editor_aa_user_path(user), method: :patch
    end
  end

  member_action :set_editor, method: :patch do
    user = User.find(params[:id])
    user.editor!
    flash[:notice] = "Successfully updated #{user.email} to editor"
    redirect_to aa_user_path(user)
  end
end
