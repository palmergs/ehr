class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_patient
  before_action :set_contact, only: [:show]
  before_action :set_writable_contact, only: [:edit, :update, :destroy]

  def index
    @contacts = Contact.by_allowed_user(current_user)
  end

  def show
    if request.xhr?
      render partial: 'contacts/contact', locals: { contact: @contact } and return
    end
  end

  def new
    @contact = Contact.new
    @contact.patient = @patient
    if request.xhr?
      render partial: 'contacts/sidebar_form' and return
    end
  end

  def edit
    if request.xhr?
      render partial: 'contacts/sidebar_form' and return
    end
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.patient = @patient
    respond_to do |format|
      if @contact.save
        format.html { redirect_to @patient, notice: 'Contact was added to patient.' }
        format.json { render action: 'show', status: :created, location: @contact }
      else
        format.html { render action: 'new' }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @contact.save
        format.html { redirect_to @patient, notice: 'Contact was successfully updates.' }
        format.json { head :no_contact }
      else
        format.html { render action: 'edit' }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to @patient }
      format.json { head :no_content }
    end
  end

  private

  def set_contact
    @contact = Contact.by_allowed_user(current_user).find(params[:id])
  end

  def set_writable_contact
    @contact = Contact.by_allowed_user(current_user).find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :contact, :msg_instr)
  end
end
