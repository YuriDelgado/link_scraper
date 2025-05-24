# frozen_string_literal: true

describe PageScraperService do
  let(:page) { create(:page, url: 'http://example.com') }
  let(:service) { described_class.new(page) }

  describe '#call' do
    context 'when the page is successfully scraped' do
      before do
        # Mock the HTTP request and response
        stub_request(:get, page.url)
          .to_return(status: 200, body: '<html><body><a href="http://example.com/link1">Link 1</a></body></html>')
      end

      it 'updates the page status to done' do
        service.call
        expect(page.reload.status).to eq('done')
      end

      it 'creates links for the page' do
        expect { service.call }.to change { page.links.count }.by(1)
        expect(page.links.first.href).to eq('http://example.com/link1')
      end
    end

    context 'when the page scraping fails' do
      before do
        # Mock a failed HTTP request
        stub_request(:get, page.url).to_return(status: 404)
      end

      it 'updates the page status to failed' do
        service.call
        expect(page.reload.status).to eq('failed')
      end
    end
  end
end
