class AddIndexToUsersGroupId < ActiveRecord::Migration
  def change
  	add_index :users, :group_id 
  end
end
