require 'spec_helper'

Dir[File.expand_path('../../../features/support/factories.rb', __FILE__)].each {|f| require f}

describe Subscription do
  describe "validations" do
    before(:each) do
      @attr = {
        :name => "rspec",
        :email => "rspec@refinery.com",
        :message => "test"
      }
    end

    it "rejects empty name" do
      Subscription.new(@attr.merge(:name => "")).should_not be_valid
    end

    it "rejects empty message" do
      Subscription.new(@attr.merge(:message => "")).should_not be_valid
    end

    it "rejects invalid email format" do
      ["", "@refinerycms.com", "refinery@cms", "refinery@cms.123"].each do |email|
        Subscription.new(@attr.merge(:email => email)).should_not be_valid
      end
    end
  end

  describe "default scope" do
    it "orders by created_at in desc" do
      subscription1 = Factory(:subscription, :created_at => 1.hour.ago)
      subscription2 = Factory(:subscription, :created_at => 2.hours.ago)
      subscriptions = Subscription.all
      subscriptions.first.should == subscription1
      subscriptions.second.should == subscription2
    end
  end

  describe ".latest" do
    it "returns latest 7 non-spam subscriptions by default" do
      8.times { Factory(:subscription) }
      Subscription.last.toggle!(:spam)
      Subscription.latest.length.should == 7
    end

    it "returns latest 7 subscriptions including spam ones" do
      4.times { Factory(:subscription) }
      3.times { Factory(:subscription) }
      Subscription.all[0..2].each { |subscription| subscription.toggle!(:spam) }
      Subscription.latest(7, true).length.should == 7
    end

    it "returns latest n subscriptions" do
      4.times { Factory(:subscription) }
      Subscription.latest(3).length.should == 3
    end
  end
end
