class Report < ActiveRecord::Base
	belongs_to :user
	validates :catalog_id, presence: true
	validates :content , presence: true
end
