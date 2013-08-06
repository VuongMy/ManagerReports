class Report < ActiveRecord::Base

	#attr_accessible :catalog_id, :content, :file_name, :paths, :user_id
  	belongs_to :user
	validates :catalog_id, presence: true
	validates :content , presence: true
default_scope order: 'reports.created_at DESC'
end
