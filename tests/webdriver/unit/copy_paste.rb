require_relative '../lib/scribe_driver'

describe "Test Copy Paste" do
  include ScribeDriver
  before do
    setup_test_suite
    start_delta = { "startLength" => 0,
                    "endLength" => 1,
                    "ops" => [{ "value" => "\n", "attributes" => {}}]}
    reset_scribe start_delta
  end

  after do
    @driver.quit
  end

  it "should copy and paste plain text" do
    skip "Copy paste all only supported on Windows + Chrome" unless WebdriverAdapter.os == :windows && @driver.browser = :chrome
    @adapter.type_text "abc"
    @adapter.copy(0, 3)
    # XXX: Adapter's paste doesn't work yet
    @adapter.paste(3)
  end

  # it "should copy and paste newlines" do
  # end

  # it "should copy and paste formatted text" do
  # end
end
