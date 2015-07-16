class Appointment < ActiveRecord::Base
  belongs_to :carpool
  belongs_to :creator, class_name: "User", foreign_key: :creator_id
  has_many :riders, dependent: :destroy
end
