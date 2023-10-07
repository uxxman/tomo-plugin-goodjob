require_relative "lib/tomo/plugin/goodjob/version"

Gem::Specification.new do |spec|
  spec.name = "tomo-plugin-goodjob"
  spec.version = Tomo::Plugin::Goodjob::VERSION
  spec.authors = ["Usman"]
  spec.email = ["uxman.sherwani@gmail.com"]

  spec.summary = "goodjob tasks for tomo"
  spec.homepage = "https://github.com/uxxman/tomo-plugin-goodjob"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/uxxman/tomo-plugin-goodjob/issues",
    "changelog_uri" => "https://github.com/uxxman/tomo-plugin-goodjob/releases",
    "source_code_uri" => "https://github.com/uxxman/tomo-plugin-goodjob",
    "homepage_uri" => spec.homepage,
    "rubygems_mfa_required" => "true"
  }

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.glob(%w[LICENSE.txt README.md {exe,lib}/**/*]).reject { |f| File.directory?(f) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "tomo", "~> 1.0"
end
