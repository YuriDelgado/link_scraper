# Link Scraper

A Rails 8 application that allows users to submit and track the status of web pages, scrape them asynchronously, and view extracted links.

## Features

- Rails 8 with built-in authentication (no Devise)
- Turbo Frames & Turbo Streams for real-time updates
- Solid Queue for background job processing
- Pagy for pagination
- Tailwind CSS for styling

---

## Getting Started

### Prerequisites

- Ruby 3.2+
- Rails 8
- PostgreSQL
- Redis (for Action Cable if needed)
- Node.js & Yarn (for JS dependencies)

### Setup

```bash
git clone https://github.com/YuriDelgado/link-scraper.git
cd link-scraper

bundle install
yarn install

rails db:setup
```

### Run the App

```bash
bin/dev
```

This runs:

- Rails server
- Tailwind via `css:watch`
- Turbo with Hotwire
- Solid Queue with inline jobs in development

---

## Usage

1. Register or log in.
2. Submit a URL.
3. The page is queued for background processing.
4. Watch the status and link count update in real-time.

---

## Architecture

- `PagesController` handles page creation and display
- `ScrapePageJob` performs async scraping using Solid Queue
- Turbo Streams broadcast updates to specific DOM elements (`<turbo-frame id="page_#{id}">`)
- Realtime features powered by ActionCable

---

## Running Tests

RSpec is used for testing.

```bash
bundle exec rspec
```

Tests are located in:

```
spec/requests/         # Request specs for controllers
spec/models/           # Model specs
spec/jobs/             # Background jobs
```

---

## Background Jobs (Solid Queue)

To run jobs manually in development:

```bash
bin/jobs
```

Or with `bin/dev`, jobs run automatically in inline mode.

---

## Turbo Streams Debugging

- Use Chrome DevTools → Network → WS tab to confirm WebSocket connection.
- Use `Turbo::StreamsChannel.broadcast_replace_to(...)` to push updates.

---

## License

MIT
