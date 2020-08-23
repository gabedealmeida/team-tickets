class Tag < ApplicationRecord
  has_many :ticket_tags, dependent: :destroy
  has_many :tickets, through: :ticket_tags, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }

  def self.options_for_select
    sort_tags.map do |tag|
      [tag.name, tag.id]
    end
  end

  def self.sort_tags
    self.all.sort_by { |tag| tag.name }
  end
end
