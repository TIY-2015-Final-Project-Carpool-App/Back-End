class RidersController < ApplicationController

  def create
    @carpool = Carpool.find_by(id: params[:id])
    if params[:username] || params[:child_id]
      params[:username] ? @ridable = User.find_by(username: params[:username]) : @ridable = Child.find_by(id: params[:id])
      if @ridable
        if @ridable.is_a? Child
          if current_user.access_token == @ridable.user.access_token
            @rider = @ridable.appo
          else 
            render json: { errors: "Unauthorized to add another user's child." }, status: :unauthorized
          end
        else

        end
      else
        render json: { errors: "No user or child found with specified username/ID." }, status: :unprocessable_entity
      end
    else
      render json: { errors: "Must provide a username or child ID." }, status: :unprocessable_entity
    end  
  end

  def update
    
  end

  def delete
    
  end

end
