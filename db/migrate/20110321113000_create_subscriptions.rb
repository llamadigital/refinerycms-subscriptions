class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    unless ::Subscription.table_exists?
      create_table ::Subscription.table_name, :force => true do |t|
        t.string   "name"
        t.string   "email"
        t.timestamps
      end

      add_index ::Subscription.table_name, :id
    end

    # todo: remove at 1.0
    create_table ::SubscriptionSetting.table_name, :force => true do |t|
      t.string   "name"
      t.text     "value"
      t.boolean  "destroyable"
      t.timestamps
    end unless ::SubscriptionSetting.table_exists?

    ::Page.reset_column_information if defined?(::Page)

    load(Rails.root.join('db', 'seeds', 'pages_for_subscriptions.rb').to_s)
  end

  def self.down
     drop_table ::Subscription.table_name
     # todo: remove at 1.0
     drop_table ::SubscriptionSetting.table_name
     Page.delete_all({:link_url => ("/subscribe" || "/subscribe/thank_you" || "/subscribe/activated" || "/subscribe/not_activated")})
  end
end

