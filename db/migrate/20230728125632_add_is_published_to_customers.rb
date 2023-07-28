class AddIsPublishedToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :is_published, :boolean, default: "TRUE"
  end
end
