module NavigationHelpers
  module Refinery
    module Subscriptions
      def path_to(page_name)
        case page_name
        when /the subscription page/
          new_subscription_path

        when /the subscription thank you page/
          thank_you_subscriptions_path

        when /the subsciption create page/
          subscriptions_path

        when /the list of subscriptions/
          admin_subscriptions_path
        else
          nil
        end
      end
    end
  end
end
