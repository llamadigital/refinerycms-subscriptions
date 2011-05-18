class AddTagsToSubscriptions < ActiveRecord::Migration
  def self.up
    if ::Subscription.table_exists?
      add_column :subscriptions, :tags, :string
    end
  end

  def self.down
    if ::Subscription.table_exists?
      remove_column :subscriptions, :tags
    end
  end
end

