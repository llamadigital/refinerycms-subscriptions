require 'csv'

class Admin::SubscriptionsController < Admin::BaseController

  crudify :subscription, :title_attribute => "email", :order => "created_at desc"
  helper_method :group_by_date

  def index
    respond_to do |format|
      format.html do
        @subscriptions = Subscription.all.with_query(params[:search]) if searching?
        @subscriptions = Subscription.all.paginate({:page => params[:page]})
      end
      format.csv do
        @subscriptions = Subscription.all
        csv_string = CSV.generate do |csv|
          csv << ['id','given_name','family_name','email','tags','activated']
          @subscriptions.each do |subscription|
            csv << [subscription.id, subscription.given_name, subscription.family_name, subscription.email, subscription.tags.join(', '), subscription.is_active? ? 'yes' : 'no']
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

