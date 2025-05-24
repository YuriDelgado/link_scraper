class Link < ApplicationRecord
  belongs_to :page, counter_cache: true

  attribute :name, :string, default: "Not name provided"
end
