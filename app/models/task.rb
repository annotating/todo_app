class Task < ActiveRecord::Base
	belongs_to :user
	validates :user_id, presence: true
	validates :note, presence: true, length: { maximum: 100 }
end
