class Contact < ActiveRecord::Base
  validates :first_name, :last_name, :relationship, :phone_number, presence: true

  belongs_to :contactable, polymorphic: true
end