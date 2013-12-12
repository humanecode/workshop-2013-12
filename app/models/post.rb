class Post < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  has_many :comments

  validates :group_id, presence: true
  validates :user_id, presence: true
  validates :date, presence: true
  validates :user_id, uniqueness: { scope: [:group_id, :date] }
end
