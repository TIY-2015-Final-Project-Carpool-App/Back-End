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
  post 'child/:id/medical', to: 'medicals#create'      # Create medical information for a child
  put 'child/:id/medical', to: 'medicals#update'       # Update medical information for a child
  delete 'child/:id/medical', to: 'medicals#delete'    # Delete medical information for a child

  # Contacts Model
  get 'child/:id/contacts', to: 'contacts#index'              # Index of contacts for a user
  get 'user/:username/contacts', to: 'contacts#index'         # Index of contacts for a child
  post 'child/:id/contacts', to: 'contacts#create'            # Create a contact for a child
  post 'users/contacts', to: 'contacts#create'                # Create a contact for the current user
  put 'contact/:id', to: 'contacts#update'                    # Update a contact
  delete 'contact/:id', to: 'contacts#delete'                 # Deletes a contact by ID

  # Carpool Model
  get 'carpools', to: 'carpools#index'                        # Index of all carpools
  get 'user/:username/carpools', to: 'carpools#index'         # Index of carpools that a user has joined or been invited to
  get 'carpool/:id', to: 'carpools#show'                      # Show a carpool
  # get 'carpool/:id/users', to: 'carpools#users'               # Index of users that joined a specific carpool
  post 'carpools', to: 'carpools#create'                      # Create a carpool
  put 'carpool/:id', to: 'carpools#update'                    # Updates a carpool
  delete 'carpool/:id', to: 'carpools#delete'                 # Delete a carpool
  delete 'carpool/:id/user/:username', to: 'carpools#remove'  # Removes a user from a carpool

  # Invites
  get 'user/:username/invites', to: 'carpools#invites'        # Index of carpools that are pending activation
  post 'carpool/:id', to: 'carpools#join'                     # Invites a user to a specific carpool
  put 'carpool/:id/activate', to: 'carpools#activate'         # Activates current user to a carpool group

end
