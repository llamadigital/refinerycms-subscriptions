require 'csv'

class Admin::SubscriptionsController < Admin::BaseController

  crudify :subscription, :title_attribute => "name", :order => "created_at DESC"
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
          csv << ['id','name','email']
          @subscriptions.each do |subscription|
            csv << [subscription.id, subscription.name, subscription.email]
          end
        end
        send_data csv_string,
          :type => 'text/csv; charset=utf8; header=present',
          :disposition => "attachment; filename=subscriptions.csv"
      end
    end
  end
end

