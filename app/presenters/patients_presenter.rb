class PatientsPresenter < CollectionPresenter
  
  def initialize current_user, params
    @criteria = current_user.patients.
        by_id(params[:id]).
        by_ident(params[:ident]).
        by_search(params[:q]).
        by_dob(params[:sdt], params[:edt])
    @criteria.order(sort_order(params))
    @collection = @criteria.page(page(params)).per(limit(params))
  end

  def sortable_columns
    [:ident, :id, :lname, :fname, :dob, :created_at]
  end
end