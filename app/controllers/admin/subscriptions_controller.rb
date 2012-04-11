require 'csv'

class Admin::SubscriptionsController < Admin::BaseController

  crudify :subscription, :title_attribute => "email", :order => "created_at desc"
  helper_method :group_by_date

  def index
    respond_to do |format|
      format.html do
        if searching?
          @subscriptions = Subscription.with_query(params[:search]).paginate({:page => params[:page]})
        else
          @subscriptions = Subscription.paginate({:page => params[:page]})
        end
      end
      format.csv do
        @subscriptions = Subscription.all

        do_activate = RefinerySetting.find_or_set('subscription_activation',false)
        #tags = Subscription.available_tag_options

        csv_string = CSV.generate do |csv|
          headings = ['id','given_name','family_name','email','tags']
          headings << 'activated' if do_activate
          csv << headings
          @subscriptions.each do |subscription|
            row = [subscription.id, subscription.given_name, subscription.family_name, subscription.email, subscription.tags.join(', ')]
            row << (subscription.is_active? ? 'yes' : 'no') if do_activate
            csv << row
          end
        end
        send_data csv_string,
          :type => 'text/csv; charset=utf8; header=present',
          :disposition => "attachment; filename=subscriptions.csv"
      end
    end
  end

  def activation
    if RefinerySetting.find_or_set(:subscription_activation, false)
      RefinerySetting.set(:subscription_activation,false)
    else
      RefinerySetting.set(:subscription_activation,true)
    end
    redirect_to :action => 'index'
  end
end

