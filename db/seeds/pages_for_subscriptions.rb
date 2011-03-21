page_position = (Page.maximum(:position, :conditions => {:parent_id => nil}) || -1)

subscribe_page = Page.create({
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
  :body => "<p>We've received your subscription request and will get back to you with a response shortly.</p><p><a href='/'>Return to the home page</a></p>",
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

