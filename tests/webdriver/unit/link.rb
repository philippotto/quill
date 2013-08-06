require_relative '../lib/scribe_driver'

describe "Link formatting" do
  include ScribeDriver
  before do
    setup_test_suite
  end

  after do
    @driver.quit
  end

  it "should create hyperlink" do
    LINK = 'https://www.google.com'
    initial = { "startLength" => 0,
                "endLength" => 4,
                "ops" => [{ "value" => "abc\n"}]
    }

    delta = { "startLength" => 4,
              "endLength" => 4,
              "ops" => [{ "start" => 0, "end" => 3, "attributes" => { "link" => LINK }},
                        { "start" => 3, "end" => 4 }]
    }

    reset_scribe initial
    ScribeDriver::JS.set_current_delta delta
    @adapter.apply_delta delta
    @adapter.set_url(LINK)
    @adapter.dismiss_link_ui
    success = ScribeDriver::JS.check_consistency
    success.must_equal true, "Failed setting hyperlink"
  end

  # The following tests require getting clicking inside contenteditable to work:
  # Test that clicking highlighting link text shows the link UI
  # Test that modifying the link in the edit box updates the link attr
end
