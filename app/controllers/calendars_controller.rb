class CalendarsController < ApplicationController 

  before_action :authenticate_user!
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  def index
    @presenter = CalendarPresenter.new(current_user, params)
  end
end
