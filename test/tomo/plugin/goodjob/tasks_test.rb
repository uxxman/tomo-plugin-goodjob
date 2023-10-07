require "test_helper"

class Tomo::Plugin::Goodjob::TasksTest < Minitest::Test
  def setup
    @tester = Tomo::Testing::MockPluginTester.new("goodjob")
  end

  def test_hello
    @tester.run_task("goodjob:hello")
    assert_equal('echo hello,\ world', @tester.executed_script)
  end
end
