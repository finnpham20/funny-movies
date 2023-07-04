# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false
      t.string :youtube_url, limit: 500, null: false
      t.string :video_id, limit: 256
      t.string :title, limit: 1000
      t.integer :status, default: 0
      t.text :description, limit: 5000
      t.timestamps
    end

    add_index :posts, :title
    add_index :posts, %i[video_id user_id], name: :index_posts_video_user_uniqueness, unique: true
  end
end
