class RidersController < ApplicationController
  before_action :authenticate_with_token!

  def create_user
    @appointment = Appointment.find(params[:id])
    @user = User.find_by!(username: params[:username])
    if current_user.access_token == @user.access_token
      @rider = @user.riders.new(appointment_id: @appointment.id, rider_role: "Passenger")
      if @rider.save
        render partial: 'appointments/appointment2', locals: { appointment: @rider.appointment }, 
               status: :created
      else
        render json: { errors: @rider.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: "Unauthorized access." }, status: :unauthorized
    end
  end

  def create_child
    @appointment = Appointment.find(params[:id])
    @child = current_user.children.find(params[:child_id])
    @rider = @child.riders.new(appointment_id: @appointment.id, rider_role: "Passenger")
    if @rider.save
      render partial: 'appointments/appointment2', locals: { appointment: @rider.appointment }, 
             status: :created
    else
      render json: { errors: @rider.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update_user
    @appointment = Appointment.find(params[:id])
    @user = User.find_by!(username: params[:username])
    if current_user.access_token == @user.access_token
      @rider = @user.riders.where(appointment_id: @appointment.id).first
      if @rider.update(rider_role: params[:rider_role])
        render partial: 'appointments/appointment2', locals: { appointment: @rider.appointment }, 
               status: :created
      else
        render json: { errors: @rider.errors.full_messages }, status: :unprocessable_entity 
      end
    else
      render json: { errors: "Unauthorized access." }, status: :unauthorized
    end
  end

  def delete_user
    @appointment = Appointment.find(id: params[:id])
    @user = User.find_by!(username: params[:username])
    if current_user.access_token == @user.access_token
      @rider = @user.riders.where(appointment_id: @appointment.id).first
      if @rider.destroy
        render json: { message: 'Deleted rider.' }, status: :no_content
      else  
        render json: { errors: @rider.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: "Unauthorized access." }, status: :unauthorized
    end
  end

  def delete_child
    @appointment = Appointment.find(params[:id])
    @child = Child.find(params[:child_id])
    if current_user.access_token == @child.user.access_token
      @rider = @child.riders.where(appointment_id: @appointment.id).first
      if @rider.destroy
        render json: { message: "Deleted rider." }, status: :no_content
      else
        render json: { errors: @rider.errors.full_messages }, status: :unprocessable_entity 
      end
    else
      render json: { errors: "Unauthorized access." }, status: :unauthorized
    end
  end
end
