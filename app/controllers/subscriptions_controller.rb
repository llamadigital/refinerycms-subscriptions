class SubscriptionsController < ApplicationController

  before_filter :find_page, :only => [:create, :new]

  def thank_you
    @page = Page.find_by_link_url("/subscribe/thank_you", :include => [:parts, :slugs])
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(params[:subscription])

    if @subscription.save

        begin
          SubscriptionMailer.notification(@subscription, request).deliver
        rescue
          logger.warn "There was an error delivering an subscription notification.\n#{$!}\n"
        end

        begin
          SubscriptionMailer.confirmation(@subscription, request).deliver
        rescue
          logger.warn "There was an error delivering an subscription confirmation:\n#{$!}\n"
        end

      redirect_to thank_you_subscriptions_url
    else
      render :action => 'new'
    end
  end

protected

  def find_page
    @page = Page.find_by_link_url('/subscribe', :include => [:parts, :slugs])
  end

end

