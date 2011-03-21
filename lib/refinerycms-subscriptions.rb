require File.expand_path('../subscriptions', __FILE__)

module Refinery
  module Subscriptions
    class Engine < Rails::Engine
      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.name = "refinery_subscriptions"
          plugin.directory = "subscriptions"
          plugin.menu_match = /(refinery|admin)\/subscription(s|_settings)$/
          plugin.activity = {
            :class => SubscriptionSetting,
            :title => 'name'
          }
        end
      end
    end
  end
end

