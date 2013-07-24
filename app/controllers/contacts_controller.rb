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
      render partial: 'contacts/contact', locals: { contact: @contact }
    else
      # default
    end
  end

  def new
    @contact = Contact.new
    @contact.patient = @patient
    if request.xhr?
      render partial: 'contacts/sidebar_form'
    else
      # default
    end
  end

end
