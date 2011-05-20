class SubscriptionMailer < ActionMailer::Base

  def activation(subscription, request)
    subject     SubscriptionSetting.activation_subject
    recipients  subscription.email
    from        "\"#{RefinerySetting[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
    reply_to    SubscriptionSetting.notification_recipients.split(',').first
    sent_on     Time.now
    @subscription = subscription
    @domain = request.domain
  end

  def confirmation(subscription, request)
    subject     SubscriptionSetting.confirmation_subject
    recipients  subscription.email
    from        "\"#{RefinerySetting[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
    reply_to    SubscriptionSetting.notification_recipients.split(',').first
    sent_on     Time.now
    @subscription = subscription
  end

  def notification(subscription, request)
    subject     SubscriptionSetting.notification_subject
    recipients  SubscriptionSetting.notification_recipients
    from        "\"#{RefinerySetting[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
    sent_on     Time.now
    @subscription = subscription
  end

end

