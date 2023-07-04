class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, limit: 256
      t.string :password_digest, null: false, limit: 256

      t.timestamps
    end

    add_index :users, :email
  end
end
