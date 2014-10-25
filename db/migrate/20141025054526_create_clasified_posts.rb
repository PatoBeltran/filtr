class CreateClasifiedPosts < ActiveRecord::Migration
  def change
    create_table :clasified_posts do |t|
      t.string :pid

      t.timestamps
    end
  end
end
