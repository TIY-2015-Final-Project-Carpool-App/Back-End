class Carpool < ActiveRecord::Base
  validates :title, presence: true

  has_many :joined_carpools, dependent: :destroy
  has_many :users, through: :joined_carpools
  belongs_to :creator, class_name: "User", foreign_key: :creator_id
  has_many :appointments, dependent: :destroy
  has_many :posts, dependent: :destroy

  def join_emails(emails)
    # @carpool = current_user.created_carpools.find(params[:id])
    ActiveRecord::Base.transaction do
      emails.each do |email|
        user = User.find_by!(email: email)
        self.users << user ## This creates a joined_carpool in the database.
        @joined = self.joined_carpools.where(user_id: user.id).first
        JoinEmailJob.perform_later(@joined)
      end
    end
    self
  end
end
