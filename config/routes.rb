Ehr::Application.routes.draw do

  resources :patients do
    resources :allergies
    resources :appointments do
      resources :progress_notes
      resources :prescriptions
    end
    resources :patient_doctor_relations
    collection do 
      get 'ethnicities', format: :json
      get 'occupations', format: :json
      get 'marital_statuses', format: :json
    end
  end

  resources :calendars

  devise_for :users

  root 'home#index'

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
