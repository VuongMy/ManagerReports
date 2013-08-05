class Report < ActiveRecord::Base
	validates :catalog_id, presence: true
	validates :content , presence: true
end
