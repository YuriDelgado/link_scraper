class Page < ApplicationRecord
  belongs_to :user
  has_many :links, dependent: :destroy

  enum :status, { pending: 0, processing: 1, done: 2, failed: 3 }

  def total_links
    links.size
  end
end
