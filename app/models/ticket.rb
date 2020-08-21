class Ticket < ApplicationRecord
  STATUS = ['new', 'blocked', 'in_progress', 'fixed']

  belongs_to :project
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :assignee, foreign_key: 'assignee_id', class_name: 'User'

  has_many :comments
  has_many :ticket_tags
  has_many :tags, through: :ticket_tags

  validates :name, presence: true, length: { minimum: 3 }
  validates :project_id, presence: true
  validates :user_id, presence: true
end
