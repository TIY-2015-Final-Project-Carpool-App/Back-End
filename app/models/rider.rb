class Rider < ActiveRecord::Base
  belongs_to :appointments
  belongs_to :ridable, polymorphic: true
end
