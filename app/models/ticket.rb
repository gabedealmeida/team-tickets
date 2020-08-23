class Ticket < ApplicationRecord
  STATUS = ['New', 'Blocked', 'In progress', 'Fixed']

  belongs_to :project
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :assignee, foreign_key: 'assignee_id', class_name: 'User'

  has_many :comments, dependent: :destroy
  has_many :ticket_tags, dependent: :destroy
  has_many :tags, through: :ticket_tags, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }
  validates :project_id, presence: true
  validates :user_id, presence: true

  def add_tags(tags_id)
    tags_id.each do |tag_id|
      self.tags << Tag.find(tag_id)
    end
  end

  def sort_comments
    self.comments.sort_by { |comment| comment.updated_at }.reverse
  end

  scope :filter_by_project, -> (id) { where('project_id = ?', id) }
  scope :filter_by_status, -> (status) { where('status = ?', status) }
  scope :filter_by_tag, -> (id) { joins(:ticket_tags).where('tag_id = ?', id) }
end
