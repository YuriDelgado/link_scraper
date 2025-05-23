class AddLinksCountToPages < ActiveRecord::Migration[8.0]
  def change
    add_column :pages, :links_count, :integer, default: 0, null: false
  end
end
