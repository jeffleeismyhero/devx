class AddCurrentBalanceToDevxPerson < ActiveRecord::Migration
  def change
    add_column :devx_people, :current_balance, :float
  end
end
