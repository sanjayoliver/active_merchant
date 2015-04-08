require 'test_helper'

class CardFlexTest < Test::Unit::TestCase
  def setup
    @gateway = CardFlexGateway.new(
      merchant_id: 'TEST_MERCHANT_ID',
      service_key: 'TEST_SERVICE_KEY'
    )

    @credit_card = credit_card
    @amount = 100

    @options = {
      order_id: '1',
      billing_address: address,
      description: 'Store Purchase'
    }
  end

  def test_successful_purchase
    @gateway.expects(:ssl_post).returns(successful_purchase_response)

    response = @gateway.purchase(@amount, @credit_card, @options)
    assert_success response

    assert_equal 'REPLACE', response.authorization
    assert response.test?
  end

  def test_failed_purchase
    @gateway.expects(:ssl_post).returns(failed_purchase_response)

    response = @gateway.purchase(@amount, @credit_card, @options)
    assert_failure response
    assert_equal Gateway::STANDARD_ERROR_CODE[:card_declined], response.error_code
  end


  def test_successful_refund
  end

  def test_failed_refund
  end

  def test_successful_void
  end

  def test_failed_void
  end

  def test_successful_verify
  end

  def test_successful_verify_with_failed_void
  end

  def test_failed_verify
  end

  def test_scrub
    assert @gateway.supports_scrubbing?
    assert_equal @gateway.scrub(pre_scrubbed), post_scrubbed
  end

  private

  def pre_scrubbed
    <<-PRE_SCRUBBED
      Run the remote tests for this gateway, and then put the contents of transcript.log here.
    PRE_SCRUBBED
  end

  def post_scrubbed
    #Put the scrubbed contents of transcript.log here after implementing your scrubbing function.
    #Things to scrub:
    #  - Routing Number
    #  - Account Number
    #  - Sensitive authentication details
    <<-POST_SCRUBBED
    POST_SCRUBBED
  end

  def successful_purchase_response
    %(
      Easy to capture by setting the DEBUG_ACTIVE_MERCHANT environment variable
      to "true" when running remote tests:

      $ DEBUG_ACTIVE_MERCHANT=true ruby -Itest \
        test/remote/gateways/remote_card_flex_test.rb \
        -n test_successful_purchase
    )
  end

  def failed_purchase_response
  end


  def successful_refund_response
  end

  def failed_refund_response
  end

  def successful_void_response
  end

  def failed_void_response
  end
end
