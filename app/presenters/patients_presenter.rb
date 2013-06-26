class PatientsPresenter < CollectionPresenter
  
  def initialize current_user, params
    @patients = current_user.patients
    @criteria = @patients.
        by_id(params[:id]).
        by_ident(params[:ident]).
        by_search(params[:q]).
        by_dob(params[:sdt], params[:edt])
    @criteria.order(sort_order(params))
    @collection = @criteria.page(page(params)).per(limit(params))
  end

  def occupations
    @patients.select('distinct patients.occupation').
        order('occupation asc').
        map(&:occupation)
  end

  def ethnicities
    @patients.select('distinct patients.ethnicity').
        order('ethnicity asc').
        map(&:ethnicity)
  end

  def marital_statuses
    @patients.select('distinct patients.marital_status').
        order('marital_status asc').
        map(&:marital_status)
  end

  def sortable_columns
    [:ident, :id, :lname, :fname, :dob, :created_at]
  end
end
