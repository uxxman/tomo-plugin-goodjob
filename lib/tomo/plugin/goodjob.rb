require "tomo"
require_relative "goodjob/helpers"
require_relative "goodjob/tasks"
require_relative "goodjob/version"

module Tomo
  module Plugin
    module Goodjob
      extend Tomo::PluginDSL

      # TODO: initialize this plugin's settings with default values
      # defaults goodjob_setting: "foo",
      #          goodjob_another_setting: "bar"

      tasks Tomo::Plugin::Goodjob::Tasks
      helpers Tomo::Plugin::Goodjob::Helpers
    end
  end
end
