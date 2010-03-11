#units test for rumeme

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), "..", "lib"))
require 'test/unit'
require "rubygems"
require 'shoulda'
require "rumeme"

include Rumeme

class SmsReplyTest < Test::Unit::TestCase
  context "SmsReply.parse method (for reply with id)" do
    setup do
      @sms_reply = SmsReply.parse("12 79270123456 100 asdfgh", true)
    end

    should "correctly parse message id" do
      assert_equal 12, @sms_reply.message_id
    end

    should "correctly parse phone number" do
      assert_equal '79270123456', @sms_reply.phone_number
    end

    should "correctly parse when" do
      assert_equal 100, @sms_reply.when
    end

    should "correctly parse message text" do
      assert_equal 'asdfgh', @sms_reply.message
    end

    should "assign NONE status " do
      assert_equal MessageStatus::NONE, @sms_reply.status
    end
  end

  context "SmsReply.parse method (for reply without id)" do
    setup do
      @sms_reply = SmsReply.parse("79270123456 100 asdfgh", false)
    end

    should "assign nil for message id" do
      assert_nil @sms_reply.message_id
    end

    should "correctly parse phone number" do
      assert_equal '79270123456', @sms_reply.phone_number
    end

    should "correctly parse when" do
      assert_equal 100, @sms_reply.when
    end 

    should "correctly parse message text" do
      assert_equal 'asdfgh', @sms_reply.message
    end

    should "assign NONE status " do
      assert_equal MessageStatus::NONE, @sms_reply.status
    end
  end

  context "SmsReply.parse method (for delivery report: pending)" do
    setup do
      @sms_reply = SmsReply.parse("12 1 100", true)
    end

    should "correctly parse message id" do
      assert_equal 12, @sms_reply.message_id
    end

    should "correctly parse when" do
      assert_equal 100, @sms_reply.when
    end

    should "assign PENDING status " do
      assert_equal MessageStatus::PENDING, @sms_reply.status
    end
  end
end