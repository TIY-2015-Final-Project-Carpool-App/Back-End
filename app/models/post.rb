class Post < ActiveRecord::Base
  validates :title, :urgency, :body, presence: true

  belongs_to :user
  belongs_to :carpool
end
