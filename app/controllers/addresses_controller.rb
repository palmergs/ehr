class AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_patient
  before_action :set_address, only: [:show]
  before_action :set_writable_address, only: [:edit, :update, :destroy]

  def index
    @addresses = Address.by_allowed_user(current_user)
  end

  def show
    if request.xhr?
      render partial: 'addresses/address', locals: { addr: @address }
    else
      # default
    end
  end

  def new
    @address = Address.new
    @address.patient = @patient
    if request.xhr?
      render partial: 'addresses/sidebar_form'
    else
      # default
    end
  end

  def edit
    if request.xhr?
      render partial: 'addresses/sidebar_form'
    else
      # default
    end
  end

  def create
    @address = Address.new(address_params)
    @address.patient = @patient
    respond_to do |format|
      if @address.save
        format.html { redirect_to @patient, notice: 'Address was added to patient.' }
        format.json { render action: 'show', status: :created, location: @address }
      else
        format.html { render action: 'new' }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @address.save
        format.html { redirect_to @patient, notice: 'Address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to @patient }
      format.json { head :no_content }
    end
  end

  private

  def set_address
    @address = Address.by_allowed_user(current_user).find(params[:id])
  end

  def set_writable_address
    @address = Address.by_allowed_user(current_user).find(params[:id])
  end

  def address_params
    params.require(:address).permit(:street, :city, :state, :zip, :name)
  end
end
