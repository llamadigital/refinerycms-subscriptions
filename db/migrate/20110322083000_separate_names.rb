class SeparateNames < ActiveRecord::Migration
  def self.up
    if ::Subscription.table_exists?
      rename_column ::Subscription.table_name, :name, :given_name      
      add_column ::Subscription.table_name, :family_name, :string
    end
  end

  def self.down
    if ::Subscription.table_exists?
      rename_column ::Subscription.table_name, :given_name, :name      
      remove_column ::Subscription.table_name, :family_name
    end     
  end
end

