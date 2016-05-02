class CreateDevxBrandings < ActiveRecord::Migration
  def change
    create_table :devx_brandings do |t|
      t.string :company_name
      t.string :logo

      t.timestamps null: false
    end
  end
end
