class AppointmentsController < ApplicationController

  def index_carpool
    @carpool = Carpool.find(params[:id])
    @appointments = @carpool.appointments
    if @appointments.empty?
      render json: { errors: "No appointments found on specifed carpool ID." }, status: :bad_request
    else
      render 'index.json.jbuilder', locals: { appointments: @appointments }, status: :ok
    end
  end

  def index_user
    @user = User.find_by!(username: params[:username])
    @riders = @user.riders
    if @riders.empty?
      render json: { errors: "No appointments found for specified user." }, status: :bad_request
    else
      render 'riders/rider_index.json.jbuilder', locals: { riders: @riders }, status: :ok
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
    render partial: 'appointment2', locals: { appointment: @appointment }, status: :ok
  end

  # Need to add restrictions to creation of appointments to users verified in the group only
  def create
    attributes = set_attributes(params)
    @carpool = Carpool.find_by(id: params[:id])
    @appointment = current_user.created_appointments.new(attributes)
    @appointment.carpool_id = @carpool.id
    if @appointment.save
      @rider = current_user.riders.create(appointment_id: @appointment.id, rider_role: "Driver")
      render partial: 'appointment2', locals: { appointment: @appointment }, status: :created
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
          render partial: 'appointment2', locals: { appointment: @appointment }, status: :ok
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
      :origin, :destination, :distance_filter
    ]
    list.each do |l|
      if params[l]
        attributes.merge!(l => params[l])
      end
    end
    attributes
  end

end