class CarpoolsController < ApplicationController
  before_action :authenticate_with_token!, except: [:activate, :remove_invite]

  def index
    @carpools = Carpool.page(params[:page]).per(params[:per])
    render 'index.json.jbuilder', status: :ok
  end

  def user_index
    @user = User.find_by!(username: params[:username])
    @carpools = Carpool.joins(:joined_carpools).where(joined_carpools: { user_id: @user } )
    render 'index.json.jbuilder', status: :ok
  end

  def invites
    @user = User.find_by!(username: params[:username])
    @joined_carpools = @user.joined_carpools.where(activated: false)
    if @joined_carpools 
      render 'invites.json.jbuilder', status: :ok
    else  
      render json: { errors: "No unaccepted carpool invitations for this user." }, status: :bad_request
    end
  end

  def show
    @carpool = Carpool.find(params[:id])
    render partial: 'carpool.json.jbuilder', locals: { carpool: @carpool }, status: :ok
  end

  def create
    attributes = set_attributes(params)
    @carpool = current_user.created_carpools.new(attributes)
    if @carpool.save
      @joined_carpool = current_user.joined_carpools.create(carpool_id: @carpool.id, activated: true)
      render partial: 'carpool.json.jbuilder', locals: { carpool: @carpool }, status: :created
    else
      render json: { errors: @carpool.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def join
    emails = params[:emails]
    @carpool = current_user.created_carpools.find_by!(id: params[:id])
    @carpool = @carpool.join_emails(emails)
    @joined_carpools = @carpool.joined_carpools
    render 'joins.json.jbuilder', locals: { joined_carpools: @joined_carpools }, status: :created
  end

  def update
    @carpool = Carpool.find(params[:id])
    attributes = set_attributes(params)
    if @carpool.update(attributes)
      render partial: 'carpool.json.jbuilder', locals: { carpool: @carpool }, status: :ok
    else
      render json: { errors: @carpool.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def activate
    if params[:join_token]
      email_activate(params)
    else
      user_activate(params)
    end
  end

  def email_activate(params)
    @invite = Carpool.find(params[:id]).joined_carpools.find_by!(join_token: params[:join_token])
    if @invite.update(activated: true)
      render json: { message: "User joined carpool." }, status: :ok
    else
      render json: { errors: @invite.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def user_activate(params)
    @carpool = Carpool.find(params[:id])
    @joined_carpool = @carpool.joined_carpools.where(user_id: current_user.id).first
    if @joined_carpool && @joined_carpool.activated == false
      if params[:join_token] == @joined_carpool.join_token
        @joined_carpool.update(activated: true)
        render partial: 'joined.json.jbuilder', locals: { joined_carpool: @joined_carpool }, status: :ok
      else  
        render json: { errors: 'Incorrect join token.' }, status: :unprocessable_entity
      end
    else
      render json: { errors: 'Current logged in user has not joined this carpool, or user is already activated.' },
                    status: :bad_request
    end
  end

  def delete
    @carpool = Carpool.find(params[:id])
    if current_user.access_token == @carpool.creator.access_token
      if @carpool.destroy
        render json: { message: "Carpool group deleted." }, status: :no_content
      else
        render json: { errors: @carpool.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: "Current user is not authorized to delete this carpool." }, 
                     status: :unauthorized
    end
  end

  def remove
    @user = User.find_by!(username: params[:username])
    @carpool = Carpool.find(params[:id])
    @joined_carpool = @carpool.joined_carpools.where(user_id: @user.id).first
    if current_user.access_token == @user.access_token || current_user.access_token == @carpool.creator.access_token
      if @joined_carpool.destroy
        render partial: 'carpool.json.jbuilder', locals: { carpool: @carpool }, status: :ok
      else
        render json: { errors: @joined_carpool.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: 'Current user is not authorized to remove this user from specified carpool.' },
                     status: :unauthorized
    end
  end

  def remove_invite
    if params[:join_token]
      email_remove_invite(params)
    else
      user_remove_invite(params)
    end
  end

  def email_remove_invite(params)
    @invite = JoinedCarpool.find(params[:id])
    if @invite.destroy
      render json: { message: "Invite Removed." }, status: :no_content
    else
      render json: { errors: @invite.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def user_remove_invite(params)
    @invite = JoinedCarpool.find(params[:id])
    @carpool_creator = @invite.carpool.creator
    @user_invite = current_user.joined_carpools.find(params[:id])
    # if current_user.access_token == @carpool_creator.access_token || current_user.access_token == @user.access_token
    if @user_invite || current_user.access_token == @carpool_creator.access_token  
      if @invite.destroy
        render json: { message: "Invite removed." }, status: :no_content
      else
        render json: { errors: @invite.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: "Current user is not authorized to remove this user's invite." },
                     status: :unauthorized
    end
  end

  private

  def set_attributes(params)
    attributes = { }
    list = [
      :title, :description
    ]
    list.each do |l|
      if params[l]
        attributes.merge!(l => params[l])
      end
    end
    attributes
  end

end



