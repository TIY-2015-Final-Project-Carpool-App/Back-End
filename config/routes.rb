Rails.application.routes.draw do
  
  # User Model
  get 'users', to: 'users#index'              # Shows all users 
  post 'users', to: 'users#create'            # Creates a user
  get 'user/:username', to: 'users#show'      # Shows one user
  put 'user/:username', to: 'users#update'    # Updates a user's attributes
  post 'users/login', to: 'users#login'       # Login to obtain access_token
  delete 'user/:username', to: 'users#delete' # Delete a user's account

  # Child Model
  get 'user/:username/children', to: 'children#index'   # Shows all children that belong to a user
  post 'children', to: 'children#create'                # Creates a child
  get 'child/:id', to: 'children#show'                  # Shows one child by ID
  put 'child/:id', to: 'children#update'                # Updates a child's atttributes
  delete 'child/:id', to: 'children#delete'             # Deletes a child

  # Medical Model
  get 'child/:id/medical', to: 'medicals#show'         # Show medical information for a child
  post 'medical', to: 'medicals#create'                # Create medical information for a child
  put 'child/:id/medical', to: 'medicals#update'       # Update medical information for a child
  delete 'child/:id/medical', to: 'medicals#delete'    # Delete medical information for a child

end
