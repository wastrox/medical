class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :email, :unique => true
      t.string :password_digest
      t.string :salt
			t.string :token
			t.string :account_type
			t.boolean :active, :default => false
			t.datetime :activated_at

      t.timestamps
    end
  end
end
