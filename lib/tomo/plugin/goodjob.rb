require "tomo"
require_relative "goodjob/tasks"
require_relative "goodjob/version"

module Tomo::Plugin::Goodjob
  extend Tomo::PluginDSL

  tasks Tomo::Plugin::Goodjob::Tasks
  defaults goodjob_systemd_service: "goodjob_%{application}.service",
           goodjob_systemd_service_path: ".config/systemd/user/%{goodjob_systemd_service}",
           goodjob_systemd_service_template_path: File.expand_path("goodjob/service.erb", __dir__)
end
