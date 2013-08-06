class RemoveFileNameFromReports < ActiveRecord::Migration
  def change
    remove_column :reports, :file_name, :string
  end
end
