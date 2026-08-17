class AddDefaultsToAccounts < ActiveRecord::Migration[8.1]
  def up
    # Preenche registros existentes que ficaram com status NULL
    execute "UPDATE accounts SET status = 0 WHERE status IS NULL"
    execute "UPDATE accounts SET account_type = 0 WHERE account_type IS NULL"
    execute "UPDATE accounts SET balance = 0 WHERE balance IS NULL"

    change_column :accounts, :status, :integer, null: false, default: 0
    change_column :accounts, :account_type, :integer, null: false, default: 0
    change_column :accounts, :balance, :decimal, precision: 12, scale: 2, null: false, default: 0
    change_column :accounts, :name, :string, null: false
  end

  def down
    change_column :accounts, :status, :integer, null: true, default: nil
    change_column :accounts, :account_type, :integer, null: true, default: nil
    change_column :accounts, :balance, :decimal, precision: 12, scale: 2, null: true, default: nil
    change_column :accounts, :name, :string, null: true
  end
end
