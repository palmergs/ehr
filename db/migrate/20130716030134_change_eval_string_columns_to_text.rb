class ChangeEvalStringColumnsToText < ActiveRecord::Migration
  def change
    change_column :initial_evaluations, :id_cc, :text, limit: nil, default: ''
    change_column :initial_evaluations, :hpi, :text, limit: nil, default: ''
    change_column :initial_evaluations, :formulation, :text, limit: nil, default: ''
    change_column :initial_evaluations, :recommendation, :text, limit: nil, default: ''
  end
end
