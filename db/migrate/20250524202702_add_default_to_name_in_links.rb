class AddDefaultToNameInLinks < ActiveRecord::Migration[8.0]
  def change
    change_column_default :links, :name, "Not name provided"
  end
end
