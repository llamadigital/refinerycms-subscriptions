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

    ::Page.reset_column_information if defined?(::Page)

    load(Rails.root.join('db', 'seeds', 'pages_for_subscriptions.rb').to_s)
  end

  def self.down
     drop_table ::Subscription.table_name
     ::Page.delete_all({:link_url => ("/subscribe" || "/subscribe/thank_you" || "/subscribe/activated" || "/subscribe/not_activated")}) if defined?(::Page)
  end
end

