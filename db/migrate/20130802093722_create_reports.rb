class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :user_id
      t.integer :catalog_id
      t.string :content
      t.data :binary, :null => false
      t.file_name :string
      #t.mime_type :string
      t.paths :string
      t.timestamps
    end
  end
end
