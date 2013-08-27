class CalendarPresenter < CollectionPresenter

  attr_reader :stdt, :endt, :range, :calendar

  def initialize current_user, params
    
    @stdt = params[:dt].present? ? 
        Date.strptime(params[:dt], '%Y%m%d') : 
        Date.today.beginning_of_week
    @endt = @stdt + 20.days
    @range = (@stdt..@endt).to_a

    @criteria = Appointment.by_allowed_user(current_user).
        by_user(params[:uid]).
        by_patient(params[:patient_id]).
        time_between(@stdt.beginning_of_day, @endt.end_of_day).
        joins(:patient).
        joins(:user)
    @criteria.order('start_at asc')
    @collection = @criteria.all.map do |appt|
      {
        id: appt.id,
        patient_id: appt.patient_id,
        patient_ident: appt.patient.ident,
        user_id: appt.user_id,
        user_name: appt.user.name,
        appt_id: appt.calendar_key
      }
    end
  end

  def sortable_columns
    [:start_at]
  end

  def default_sort_dir
    :asc
  end
end
