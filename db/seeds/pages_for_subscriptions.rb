::User.find(:all).each do |user|
  if user.plugins.where(:name => 'refinery_subscriptions').blank?
    user.plugins.create(:name => "refinery_subscriptions", :position => (user.plugins.maximum(:position) || -1) +1)
  end
end if defined?(::User)

if defined?(::Page)
  page_position = (::Page.maximum(:position, :conditions => {:parent_id => nil}) || -1)

  subscribe_page = ::Page.create({
    :title => "Subscribe to newsletter",
    :link_url => "/subscribe",
    :menu_match => "^/subscriptions.*$",
    :deletable => false,
    :position => (page_position += 1)
  })

  subscribe_page.parts.create({
    :title => "Body",
    :body => "<p>Just use the form below and we'll add you to our newsletter subscription list.</p>",
    :position => 0
  })
  subscribe_page.parts.create({
    :title => "Side Body",
    :body => "<p>Side bar</p>",
    :position => 1
  })
  subscribe_page_position = -1

  thank_you_page = subscribe_page.children.create({
    :title => "Thank You",
    :link_url => "/subscribe/thank_you",
    :menu_match => "^/subscriptions/thank_you$",
    :show_in_menu => false,
    :deletable => false,
    :position => (subscribe_page_position += 1)
  })
  thank_you_page.parts.create({
    :title => "Body",
    :body => "<p>We've received your subscription request.</p><p><a href='/'>Return to the home page</a></p>",
    :position => 0
  })

  activated_page = subscribe_page.children.create({
    :title => "Activated",
    :link_url => "/subscribe/activated",
    :menu_match => "^/subscriptions/activated$",
    :show_in_menu => false,
    :deletable => false,
    :position => (subscribe_page_position += 1)
  })
  activated_page.parts.create({
    :title => "Body",
    :body => "<p>Thank you for activating your subscription.</p><p><a href='/'>Return to the home page</a></p>",
    :position => 0
  })

  not_activated_page = subscribe_page.children.create({
    :title => "Not Activated",
    :link_url => "/subscribe/not_activated",
    :menu_match => "^/subscriptions/not_activated$",
    :show_in_menu => false,
    :deletable => false,
    :position => (subscribe_page_position += 1)
  })
  not_activated_page.parts.create({
    :title => "Body",
    :body => "<p>Your subscription request cannot be activated at this time, please try again later.</p><p><a href='/'>Return to the home page</a></p>",
    :position => 0
  })

  privacy_policy_page = subscribe_page.children.create({
    :title => "Privacy Policy",
    :deletable => true,
    :show_in_menu => false,
    :position => (subscribe_page_position += 1)
  })
  privacy_policy_page.parts.create({
    :title => "Body",
    :body => "<p>We respect your privacy. We do not market, rent or sell our email list to any outside parties.</p><p>We need your e-mail address so that we can ensure that the people using our forms are bona fide. It also allows us to send you e-mail newsletters and other communications, if you opt-in. Your postal address is required in order to send you information and pricing, if you request it.</p><p>Please call us at 123 456 7890 if you have any questions or concerns.</p>",
    :position => 0
  })
end
