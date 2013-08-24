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
    @collection = @criteria.all

    @calendar = @range.inject({}) { |hash, dt| hash[dt] = {}; hash }
    @collection.each do |appt|
      @calendar[appt.start_at.to_date][appt.start_at.hour] = appt
    end
  end

  def sortable_columns
    [:start_at]
  end

  def default_sort_dir
    :asc
  end
end
