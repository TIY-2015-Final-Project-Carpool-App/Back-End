class RidersController < ApplicationController

  def create
    @appointment = Appointment.find_by(id: params[:id])
    if params[:username] || params[:child_id]
      params[:username] ? @ridable = User.find_by(username: params[:username]) : @ridable = Child.find_by(id: params[:id])
      if @ridable
        if @ridable.is_a? Child
          if current_user.access_token == @ridable.user.access_token
            @rider = @ridable.riders.new(appointment_id: @appointment.id)
            if @rider.save
              render partial: 'appointment/appointment2', locals: { appointment: @rider.appointment }, status: :created
            else
              render json: { errors: @rider.errors.full_messages }, status: :unprocessable_entity
            end
          else 
            render json: { errors: "Unauthorized to add another user's child." }, status: :unauthorized
          end
        else
          if current_user.access_token == @ridable.access_token 
            @rider = @ridable.riders.new(appointment_id: @appointment.id)
            if @rider.save
              render partial: 'appointment/appointment2', locals: { appointment: @rider.appointment }, status: :created
            else
              render json: { errors: @rider.errors.full_messages }, status: :unprocessable_entity
            end
          else
            render json: { errors: "Unauthorized to add another user to an appointment." }, status: :unauthorized
          end
        end
      else
        render json: { errors: "No user or child found with specified username/ID." }, status: :unprocessable_entity
      end
    else
      render json: { errors: "Must provide a username or child ID." }, status: :unprocessable_entity
    end  
  end

  def update
    @appointment = Appointment.find_by(id: params[:id])
    if params[:username] || params[:child_id]
      params[:username] ? @ridable = User.find_by(username: params[:username]) : @ridable = Child.find_by(id: params[:id])
      if @ridable.is_a? Child
        if current_user.access_token == @ridable.user.access_token
          if @ridable.update(rider_role: params[:rider_role])
            render partial: 'appointment/appointment2', locals: { appointment: @rider.appointment }, status: :created
          else
            render json: { errors: @ridable.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { errors: "Unauthorized access." }, status: :unauthorized
        end
      else
        if current_user.access_token == @ridable.access_token
          if @ridable.update(rider_role: params[:rider_role])
            render partial: 'appointment/appointment2', locals: { appointment: @rider.appointment }, status: :created
          else
            render json: { errors: @ridable.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { errors: "Unauthorized access." }, status: :unauthorized
        end
      end
    else
      render json: { errors: "Must provide a username or child ID." }, status: :unprocessable_entity
    end
  end

  def delete
    @appointment = Appointment.find_by(id: params[:id])
    if params[:username] || params[:child_id]
      params[:username] ? @ridable = User.find_by(username: params[:username]) : @ridable = Child.find_by(id: params[:id])
      if @ridable.is_a? Child
        if current_user.access_token == @ridable.user.access_token
          if @ridable.destroy
            render json: { message: "Rider deleted." }, status: :no_content
          else
            render json: { errors: @ridable.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { errors: "Unauthorized access." }, status: :unauthorized
        end
      else
        if current_user.access_token == @ridable.access_token
          if @ridable.destroy
            render json: { message: "Rider deleted" }, status: :no_content
          else
            render json: { errors: @ridable.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { errors: "Unauthorized access." }, status: :unauthorized
        end
      end
    else
      render json: { errors: "Must provide a username or child ID." }, status: :unprocessable_entity
    end
  end

end
