class SubscriptionSetting < ActiveRecord::Base

  def self.confirmation_body
    RefinerySetting.find_or_set(:subscription_confirmation_body,"Thank you for your subscription %name%,\n\nThis email is a receipt to confirm we have received your subscription and we'll be in touch shortly.\n\nThanks.")
  end

  def self.confirmation_subject
    RefinerySetting.find_or_set(:subscription_confirmation_subject, "Thank you for your subscription")
  end

  def self.confirmation_subject=(value)
    # handles a change in Refinery API
    if RefinerySetting.methods.map(&:to_sym).include?(:set)
      RefinerySetting.set(:subscription_confirmation_subject, value)
    else
      RefinerySetting[:subscription_confirmation_subject] = value
    end
  end

  def self.activation_body
    RefinerySetting.find_or_set(:subscription_activation_body,"Thank you for your subscription request %name%,\n\nTo activate your subscription click this <a href=\"%url%\">link</a>.\n\nThanks.")
  end

  def self.activation_subject
    RefinerySetting.find_or_set(:subscription_activation_subject, "Please activate your subscription")
  end

  def self.activation_subject=(value)
    # handles a change in Refinery API
    if RefinerySetting.methods.map(&:to_sym).include?(:set)
      RefinerySetting.set(:subscription_activation_subject, value)
    else
      RefinerySetting[:subscription_activation_subject] = value
    end
  end

  def self.notification_recipients
    RefinerySetting.find_or_set(:subscription_notification_recipients,((Role[:refinery].users.first.email rescue nil) if defined?(Role)).to_s)
  end

  def self.notification_subject
    RefinerySetting.find_or_set(:subscription_notification_subject,"New subscription from your website")
  end

  def self.tags
    RefinerySetting.find_or_set(:subscription_tags,"")
  end

end

