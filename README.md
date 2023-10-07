# tomo-plugin-goodjob

[![Gem Version](https://img.shields.io/gem/v/tomo-plugin-goodjob)](https://rubygems.org/gems/tomo-plugin-goodjob)
[![Gem Downloads](https://img.shields.io/gem/dt/tomo-plugin-goodjob)](https://www.ruby-toolbox.com/projects/tomo-plugin-goodjob)
[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/uxxman/tomo-plugin-goodjob/ci.yml)](https://github.com/uxxman/tomo-plugin-goodjob/actions/workflows/ci.yml)
[![Code Climate maintainability](https://img.shields.io/codeclimate/maintainability/uxxman/tomo-plugin-goodjob)](https://codeclimate.com/github/uxxman/tomo-plugin-goodjob)

This is a [tomo](https://github.com/uxxman/tomo) plugin that provides tasks for managing [GoodJob](https://github.com/bensheldon/good_job) via [systemd](https://en.wikipedia.org/wiki/Systemd), based on the recommendations in the goodjob documentation. This plugin assumes that you are also using the tomo `rbenv` and `env` plugins, and that you are using a systemd-based Linux distribution like Ubuntu 18 LTS.

**This plugin requires GoodJob 3.19 or newer.**

---

- [Installation](#installation)
- [Settings](#settings)
- [Tasks](#tasks)
- [Recommendations](#recommendations)
- [Support](#support)
- [License](#license)
- [Code of conduct](#code-of-conduct)
- [Contribution guide](#contribution-guide)

## Installation

Run:

```
$ gem install tomo-plugin-goodjob
```

Or add it to your Gemfile:

```ruby
gem "tomo-plugin-goodjob"
```

Then add the following to `.tomo/config.rb`:

```ruby
plugin "goodjob"

setup do
  # ...
  run "goodjob:setup_systemd"
end

deploy do
  # ...
  # Place this task at *after* core:symlink_current
  run "goodjob:restart"
end
```

### enable-linger

This plugin installs goodjob as a user-level service using `systemctl --user`. This allows goodjob to be installed, started, stopped, and restarted without a root user or sudo. However, when provisioning the host you must make sure to run the following command as root to allow the goodjob process to continue running even after the tomo deploy user disconnects:

```
# run as root
$ loginctl enable-linger <DEPLOY_USER>
```

## Settings

| Name                  | Purpose |
| --------------------- | ------- |
| `goodjob_systemd_service` | Name of the systemd unit that will be used to manage goodjob <br>**Default:** `"goodjob_%{application}.service"`   |
| `goodjob_systemd_service_path` | Location where the systemd unit will be installed <br>**Default:** `".config/systemd/user/%{goodjob_systemd_service}"`   |
| `goodjob_systemd_service_template_path` | Local path to the ERB template that will be used to create the systemd unit <br>**Default:** [service.erb](https://github.com/uxxman/tomo-plugin-goodjob/blob/main/lib/tomo/plugin/goodjob/service.erb)   |

## Tasks

### goodjob:setup_systemd

Configures systemd to manage goodjob. This means that goodjob will automatically be restarted if it crashes, or if the host is rebooted. This task essentially does two things:

1. Installs a `goodjob.service` systemd unit
1. Enables it using `systemctl --user enable`

Note that these units will be installed and run for the deploy user. You can use `:goodjob_systemd_service_template_path` to provide your own template and customize how goodjob and systemd are configured.

`goodjob:setup_systemd` is intended for use as a [setup](https://tomo-deploy.com/commands/setup/) task. It must be run before goodjob can be started during a deploy.

### goodjob:restart

Gracefully restarts the goodjob service via systemd, or starts it if it isn't running already. Equivalent to:

```
systemctl --user restart goodjob.service
```

### goodjob:start

Starts the goodjob service via systemd, if it isn't running already. Equivalent to:

```
systemctl --user start goodjob.service
```

### goodjob:stop

Stops the goodjob service via systemd. Equivalent to:

```
systemctl --user stop goodjob.service
```

### goodjob:status

Prints the status of the goodjob systemd service. Equivalent to:

```
systemctl --user status goodjob.service
```

### goodjob:log

Uses `journalctl` (part of systemd) to view the log output of the goodjob service. This task is intended for use as a [run](https://tomo-deploy.com/commands/run/) task and accepts command-line arguments. The arguments are passed through to the `journalctl` command. For example:

```
$ tomo run -- goodjob:log -f
```

Will run this remote script:

```
journalctl -q --user-unit=goodjob.service -f
```

## Recommendations

### GoodJob configuration

You can tune goodjob for each environment by simply setting environment variables (e.g. using `tomo run env:set`), without hard-coding configuration in git or within systemd files.

## Support

If you want to report a bug, or have ideas, feedback or questions about the gem, [let me know via GitHub issues](https://github.com/uxxman/tomo-plugin-goodjob/issues/new) and I will do my best to provide a helpful answer. Happy hacking!

## License

The gem is available as open source under the terms of the [MIT License](LICENSE.txt).

## Code of conduct

Everyone interacting in this project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).

## Contribution guide

Pull requests are welcome!
