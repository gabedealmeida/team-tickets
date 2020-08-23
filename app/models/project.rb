class Project < ApplicationRecord
  has_many :tickets, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: true
  validates :description, presence: true

  def self.options_for_select
    Project.all.map do |project|
      [project.name, project.id]
    end
  end

  def open_tickets_count
    self.tickets.select do |ticket|
      status = ticket.status
      status == 'New' || status == 'Blocked' || status == 'In progress'
    end.size
  end

  def most_recent_update
    most_recent = ''

    self.tickets.each_with_index do |ticket, idx|
      most_recent = ticket.updated_at if idx == 0

      if most_recent < ticket.updated_at
        most_recent = ticket.updated_at
      end
    end
    most_recent == '' ? self.updated_at : most_recent
  end
end
