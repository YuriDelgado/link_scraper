# frozen_string_literal: true

FactoryBot.define do
  factory :page do
    url { "http://example.com" }
    status { :pending }
    association :user
  end
end
