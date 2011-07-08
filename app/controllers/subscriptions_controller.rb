class SubscriptionsController < ApplicationController

  # this default controller expects pages that are set to link to
  # /subscribe
  # /subscribe/thank_you
  # /subscribe/activated
  # /subscribe/not_activated
  # these pages never get loaded by the page controller
  # these pages do not use the thank-you urls with the hyphens
  # the hyphenated urls come from the page controller slug system

  before_filter :find_page, :only => [:create, :new]

  def thank_you
    @page = Page.find_by_link_url("/subscribe/thank_you", :include => [:parts, :slugs])
    render :default
  end

  def new
    @subscription = Subscription.new
  end

  def create
    tags = params[:subscription].delete(:tags)
    @subscription = Subscription.new(params[:subscription])
    # this is generic
    @subscription.tags = tags if tags.is_a? Array
    # this is for radio buttons
    @subscription.tags = [tags] if tags.is_a? String
    # this is for checkboxes
    @subscription.tags = tags.keys if tags.is_a? Hash

    do_activate = RefinerySetting.find_or_set('subscription_activation',false)

    if @subscription.save

      begin
        SubscriptionMailer.activation(@subscription, request).deliver
      rescue
        logger.warn "There was an error delivering a subscription request.\n#{$!.inspect}\n#{$@.join('\n')}\n"
      end
      redirect_to thank_you_subscriptions_url
    else
      render :action => 'new'
    end
  end

  def activate
    token = params[:token]
    @subscription = Subscription.can_activate.all.reject { |s| s.activation_token!=token }
    if @subscription.blank? || @subscription.size > 1
      redirect_to not_activated_subscriptions_url
    else
      @subscription.first.activate!
      begin
        SubscriptionMailer.notification(@subscription.first, request).deliver
      rescue
        logger.warn "There was an error delivering a subscription activation notification.\n#{$!.inspect}\n#{$@.join('\n')}\n"
      end
      begin
        SubscriptionMailer.confirmation(@subscription.first, request).deliver
      rescue
        logger.warn "There was an error delivering a subscription activation confirmation.\n#{$!.inspect}\n#{$@.join('\n')}\n"
      end

      redirect_to activated_subscriptions_url
    end
  end

  def activated
    @page = Page.find_by_link_url("/subscribe/activated", :include => [:parts, :slugs])
    render :default
  end

  def not_activated
    @page = Page.find_by_link_url("/subscribe/not_activated", :include => [:parts, :slugs])
    render :default
  end

  protected

  def find_page
    @page = Page.find_by_link_url('/subscribe', :include => [:parts, :slugs])
  end

end

