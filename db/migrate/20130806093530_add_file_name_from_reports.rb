class AddFileNameFromReports < ActiveRecord::Migration
  def change
    add_column :reports, :file_name, :string
  end
end
