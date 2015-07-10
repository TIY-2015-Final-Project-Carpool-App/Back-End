class Child < ActiveRecord::Base
  validates :first_name, :last_name, presence: true

  belongs_to :user
  has_one :medical
  has_many :contacts, as: :contactable
end
