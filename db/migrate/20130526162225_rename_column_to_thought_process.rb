class RenameColumnToThoughtProcess < ActiveRecord::Migration
  def change
    rename_column :progress_notes, :though_process, :thought_process
  end
end
