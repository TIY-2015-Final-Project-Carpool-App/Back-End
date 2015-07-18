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
  # get 'carpool/:id/users', to: 'carpools#users'             # Index of users that joined a specific carpool
  post 'carpools', to: 'carpools#create'                      # Create a carpool
  put 'carpool/:id', to: 'carpools#update'                    # Updates a carpool
  delete 'carpool/:id', to: 'carpools#delete'                 # Delete a carpool
  delete 'carpool/:id/user/:username', to: 'carpools#remove'  # Removes a user from a carpool

  # Invites
  get 'user/:username/invites', to: 'carpools#invites'        # Index of carpools that are pending activation
  post 'carpool/:id', to: 'carpools#join'                     # Invites a user to a specific carpool
  put 'carpool/:id/activate', to: 'carpools#activate'         # Activates current user to a carpool group
  # delete 'invite/:id', to: 'carpool#remove_invite'            # Declines an invite to a carpool group

  # Appointments
  get 'carpool/:id/appointments', to: 'appointments#index_carpool'  # Index of appointments in a carpool
  get 'user/:username/appointments', to: 'appointments#index_user'  # Index of appointments a user has (rider or driver) * Add query params to specify driver/rider
  get 'appointment/:id', to: 'appointments#show'                    # Shows an individual appointment
  post 'carpool/:id/appointments', to: 'appointments#create'        # Creates an appointment for a carpool, auto adds the creator 
  put 'appointment/:id', to: 'appointments#update'                  # Updates an appointment
  delete 'appointment/:id', to: 'appointments#delete'               # Deletes an appointment

  # Riders
  post 'user/:username/appointment/:id/join', to: 'riders#create_user'    # Joins a user to an appointment
  post 'child/:child_id/appointment/:id/join', to: 'riders#create_child'  # Joins a child to an appointment
  put 'user/:username/appointment/:id', to: 'riders#update_user'          # Updates a user's rider role
  delete 'user/:username/appointment/:id', to: 'riders#delete_user'       # Removes a user from an appointment
  delete 'child/:child_id/appointment/:id', to: 'riders#delete_child'     # Removes a child from an appointment

  # Posts
  get 'carpool/:id/posts', to: 'posts#index'    # Index of a carpool's index
  get 'post/:id', to: 'posts#show'              # Show a specific post
  post 'carpool/:id/posts', to: 'posts#create'  # Creates a post on a carpool
  put 'post/:id', to: 'posts#update'            # Updates a post on a carpool
  delete 'post/:id', to: 'posts#delete'         # Deletes a post on a carpool

end
