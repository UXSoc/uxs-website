Rails.application.routes.draw do
  comfy_route :cms_admin, path: "/admin"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  devise_scope :user do
    authenticated do
      root "dashboard#show"
    end

    unauthenticated do
      root "devise/sessions#new"
    end
  end

  # Ensure that this route is defined last
  comfy_route :cms, path: "/cms"
end
