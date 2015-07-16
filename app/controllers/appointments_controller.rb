class AppointmentsController < ApplicationController

  def index
    if params[:id]
      @carpool = Carpool.find_by(id: params[:id])
      if @carpool
        @appointments = @carpool.appointments
        if !@appointments.empty?
          render 'index.json.jbuilder', locals: { appointments: @appointments }, status: :ok
          # Incomplete, need to add riders to json response
        else
          render json: { errors: "No appointments found on specifed carpool ID." }, status: :bad_request
        end
      else
        render json: { errors: "No carpool found with specified ID." }, status: :bad_request
      end
    else
      @user = User.find_by(username: params[:username])
      if @user
        if params[:created] == true
          @appointments = @user.created_appointments
          if !@appointments.empty?
            render 'index.json.jbuilder', locals: { appointments: @appointments }, status: :ok
          else
            render json: { errors: "No appointments created by specified user." }, status: :bad_request
          end
        else
          @riders = @user.riders
          if !@riders.empty?
            render 'riders/rider_index.json.jbuilder', locals: { riders: @riders }, status: :ok
          else
            render json: { errors: "No appointments found for specified user." }, status: :bad_request
          end
        end
      else
        render json: { errors: "No user found with specified username." }, status: :bad_request
      end
    end 
  end

  def show
    @appointment = Appointment.find_by(id: params[:id])
    if @appointment
      render partial: 'appointment', locals: { appointment: @appointment }, status: :ok
    else
      render json: { errors: "No appointment found with specified ID." }, status: :bad_request
    end
  end

  # Need to add restrictions to creation of appointments to users verified in the group only
  def create
    attributes = set_attributes(params)
    @carpool = Carpool.find_by(id: params[:id])
    @appointment = current_user.created_appointments.new(attributes)
    @appointment.carpool_id = @carpool.id
    if @appointment.save
      @rider = current_user.riders.create(appointment_id: @appointment.id, rider_role: "Driver")
      render partial: 'appointment', locals: { appointment: @appointment }, status: :created
    else
      render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    attributes = set_attributes(params)
    @appointment = Appointment.find_by(id: params[:id])
    if @appointment
      if current_user.access_token == @appointment.creator.access_token
        if @appointment.update(attributes)
          render partial: 'appointment', locals: { appointment: @appointment }, status: :ok
        else
          render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { errors: "Unauthorized access. Must be the creator to update." }, status: :unauthorized
      end
    else
      render json: { errors: "No appointment found with specified ID." }, status: :bad_request
    end
  end

  def delete
    @appointment = Appointment.find_by(id: params[:id])
    if @appointment
      if current_user.access_token == @appointment.creator.access_token
        if @appointment.destroy
          render json: { message: "Appointment deleted." }, status: :no_content
        else
          render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { errors: "Unauthorized access. Must be the creator to delete." }, status: :unauthorized
      end
    else
      render json: { errors: "No appointment found with specified ID." }, status: :bad_request
    end
  end

  private

  def set_attributes(params)
    attributes = { }
    list = [
      :start, :title, :description,
      :origin, :destination, :email, :avatar
    ]
    list.each do |l|
      if params[l]
        attributes.merge!(l => params[l])
      end
    end
    attributes
  end

end