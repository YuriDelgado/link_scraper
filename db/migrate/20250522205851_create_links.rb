class CreateLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :links do |t|
      t.string :name
      t.string :href
      t.references :page, null: false, foreign_key: true

      t.timestamps
    end
  end
end
