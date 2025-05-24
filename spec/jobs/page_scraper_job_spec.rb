# frozen_string_literal: true

describe ScrapePageJob, type: :job do
  let(:page) { create(:page) }

  describe '#perform' do
    it 'calls the PageScraperService with the correct page' do
      # Mock the PageScraperService
      service = instance_double(PageScraperService)
      allow(PageScraperService).to receive(:new).with(page).and_return(service)
      expect(service).to receive(:call)

      # Perform the job
      described_class.perform_now(page.id)
    end
  end

  describe 'queueing' do
    it 'queues the job' do
      expect {
        described_class.perform_later(page.id)
      }.to have_enqueued_job(ScrapePageJob).with(page.id)
    end
  end
end
