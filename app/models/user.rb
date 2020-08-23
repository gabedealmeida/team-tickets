class User < ApplicationRecord
  has_many :tickets
  has_many :comments

  has_secure_password

  validates :username, presence: true, length: { minimum: 3 }, uniqueness: true
  validates :password, presence: true, on: :create, length: { minimum: 5 }, confirmation: true

  def self.options_for_select
    User.all.map do |user|
      [user.username, user.id]
    end
  end
end
