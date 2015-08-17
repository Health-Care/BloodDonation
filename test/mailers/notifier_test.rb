require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "gmail_message" do
    mail = Notifier.gmail_message
    assert_equal "Gmail message", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
