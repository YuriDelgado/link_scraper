class Page < ApplicationRecord
  belongs_to :user
  has_many :links, dependent: :destroy
  after_update_commit lambda {
    broadcast_replace_to "pages", target: "page_#{id}_row"
  }
  validates :url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }
  enum :status, { pending: 0, processing: 1, done: 2, failed: 3 }
end
