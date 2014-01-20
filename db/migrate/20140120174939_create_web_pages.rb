class CreateWebPages < ActiveRecord::Migration
  def change
    create_table :web_pages do |t|
      t.string :title
      t.string :summary
      t.integer :user_id

      t.timestamps
    end
  end
end
