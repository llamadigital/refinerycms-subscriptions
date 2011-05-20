class AddActivatedToSubscriptions < ActiveRecord::Migration
  def self.up
    if ::Subscription.table_exists?
      add_column :subscriptions, :activated, :boolean, :default=>false
    end
  end

  def self.down
    if ::Subscription.table_exists?
      remove_column :subscriptions, :activated
    end
  end
end

