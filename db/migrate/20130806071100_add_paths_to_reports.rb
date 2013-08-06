class AddPathsToReports < ActiveRecord::Migration
  def change
    add_column :reports, :paths, :string
  end
end
