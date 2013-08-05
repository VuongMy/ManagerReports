class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :user_id
      t.integer :catalog_id
      t.string :content

      t.timestamps
    end
  end
end
