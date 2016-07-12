class RenameUserForDevxAccountTransactionsToDevxPerson < ActiveRecord::Migration
  def change
    rename_column :devx_account_transactions, :user_id, :person_id
  end
end
