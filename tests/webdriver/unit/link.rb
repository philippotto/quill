require_relative '../lib/scribe_driver'

describe "Link formatting" do
  include ScribeDriver
  before do
    setup_test_suite
  end

  after do
    @driver.quit
  end

  # Test that applying link works
  # Test that clicking highlighting link text shows the link UI
  # Test that modifying the link in the edit box updates the link attr

  it "should hyperlink text" do
    initial = { "startLength" => 0,
                "endLength" => 4,
                "ops" => [{ "value" => "abc\n"}]
    }

    delta = { "startLength" => 4,
              "endLength" => 4,
              "ops" => [{ "start" => 0, "end" => 3, "attributes" => { "link" => true }},
                        { "start" => 3, "end" => 4 }]
    }

    reset_scribe initial
    @adapter.apply_delta delta, "Couldn't apply"
    @adapter.set_url('http://www.google.com')
    done = @driver.find_element(:css, "#link-tooltip .done")
    done.click
    @adapter.dismiss_link_ui
  end
end
