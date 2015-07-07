Rails.application.routes.draw do
  
  # User Model
  get 'users', to: 'users#index'              # Shows all users 
  post 'users', to: 'users#create'            # Creates a user
  get 'user/:username', to: 'users#show'      # Shows one user
  put 'user/:username', to: 'users#update'    # Updates a user's attributes
  post 'users/login', to: 'users#login'       # Login to obtain access_token
  delete 'user/:username', to: 'users#delete' # Delete a user's account
end
