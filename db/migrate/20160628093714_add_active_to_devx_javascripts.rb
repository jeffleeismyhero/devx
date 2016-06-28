class AddActiveToDevxJavascripts < ActiveRecord::Migration
  def change
    add_column :devx_javascripts, :active, :boolean
  end
end
