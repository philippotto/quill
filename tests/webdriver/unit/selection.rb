require_relative '../lib/scribe_driver'

describe "Highlight" do
  include ScribeDriver

  before do
    setup_test_suite
  end

  after do
    @driver.quit
  end

  def validate_selection(expected, actual, err_msg)
    assert expected == actual, err_msg
  end

  it "should highlight newline" do
    start_delta = { "startLength" => 0,
                    "endLength" => 7,
                    "ops" => [{ "value" => "abc\ndef\n", "attributes" => {}}]}
    reset_scribe start_delta

    @adapter.move_cursor 2
    @adapter.highlight 2

    selection = ScribeDriver::JS.get_selection
    assert selection['start'] == 2
    assert selection['end'] == 4
  end

  it "should highlight from head to tail" do
    start_delta = { "startLength" => 0,
                    "endLength" => 7,
                    "ops" => [{ "value" => "abc\ndef\n", "attributes" => {}}]}
    reset_scribe start_delta

    @adapter.move_cursor 0
    @adapter.highlight 7

    selection = ScribeDriver::JS.get_selection
    assert selection['start'] == 0
    assert selection['end'] == 7
  end

  it "should highlight from tail to head" do
    start_delta = { "startLength" => 0,
                    "endLength" => 7,
                    "ops" => [{ "value" => "abc\ndef\n", "attributes" => {}}]}
    reset_scribe start_delta

    @adapter.move_cursor 7
    @adapter.highlight 7, true

    selection = ScribeDriver::JS.get_selection
    assert selection['start'] == 0
    assert selection['end'] == 7
    assert selection['isBackwards'] == true
  end

  it "should highlight all" do
    start_delta = { "startLength" => 0,
                    "endLength" => 7,
                    "ops" => [{ "value" => "abc\ndef\n", "attributes" => {}}]}
    reset_scribe start_delta

    @adapter.highlight_all

    selection = ScribeDriver::JS.get_selection
    assert selection['start'] == 0
    assert selection['end'] == 7
  end
end
