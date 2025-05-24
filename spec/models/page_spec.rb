# frozen_string_literal: true

RSpec.describe Page, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:links).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:url) }
    it { should allow_value('http://example.com').for(:url) }
    it { should allow_value('https://example.com').for(:url) }
    it { should_not allow_value('invalid_url').for(:url) }
    it { should_not allow_value('').for(:url) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(pending: 0, processing: 1, done: 2, failed: 3) }
  end
end
