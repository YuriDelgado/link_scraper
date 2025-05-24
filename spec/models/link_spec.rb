RSpec.describe Link, type: :model do
  describe 'associations' do
    it { should belong_to(:page).counter_cache(true) }
  end

  describe 'default values' do
    it 'sets the default value for name to "Not name provided"' do
      link = Link.new
      expect(link.name).to eq("Not name provided")
    end
  end
end
