class AddRelationships < ActiveRecord::Migration
  def change
    add_column :services, :user_id, :integer
    add_column :services, :desc, :string
    add_column :statuses, :state, :string
    add_column :statuses, :service_id, :integer
    add_column :statuses, :message, :string
    add_column :statuses, :time, :datetime
    
    add_index :services, :user_id
    add_index :statuses, :service_id    
  end

end
