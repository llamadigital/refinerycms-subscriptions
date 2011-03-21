require 'csv'

class Admin::SubscriptionsController < Admin::BaseController

  crudify :subscription, :title_attribute => "name", :order => "created_at DESC"
  helper_method :group_by_date

  before_filter :find_all_ham, :only => [:index]
  before_filter :find_all_spam, :only => [:spam]
  before_filter :get_spam_count, :only => [:index, :spam]

  def index
    respond_to do |format|
      format.html do
        @subscriptions = @subscriptions.with_query(params[:search]) if searching?
        @subscriptions = @subscriptions.paginate({:page => params[:page]})
      end
      format.csv do
        @subscriptions = @subscriptions.all
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

  def spam
    self.index
    render :action => 'index'
  end

  def toggle_spam
    find_subscription
    @subscription.toggle!(:spam)

    redirect_to :back
  end

protected

  def find_all_ham
    @subscriptions = Subscription.ham
  end

  def find_all_spam
    @subscriptions = Subscription.spam
  end

  def get_spam_count
    @spam_count = Subscription.count(:conditions => {:spam => true})
  end

end

