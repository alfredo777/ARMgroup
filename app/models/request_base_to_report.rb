class RequestBaseToReport < ActiveRecord::Base
	belongs_to :campaing
	has_many :work_schemas

	mount_uploader :csv_adress, BaseMountedByCampaingUploader

end
