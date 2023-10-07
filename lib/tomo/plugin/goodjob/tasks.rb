module Tomo::Plugin::Goodjob
  class Tasks < Tomo::TaskLibrary
    # Defines a goodjob:hello task
    def hello
      remote.run "echo", "hello, world"
    end
  end
end
