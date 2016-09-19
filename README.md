[![Version](https://img.shields.io/gem/v/thinreports-template-cli.svg)](https://rubygems.org/gems/thinreports-template-cli)

# thinreports-template-cli

## Installation

    $ gem install thinreports-template-cli

## Usage

```bash
$ thinreports-template-cli help
Commands:
  thinreports-template-cli config --layout=LAYOUT    # Create config file for .tlf
  thinreports-template-cli generate --layout=LAYOUT  # Generate a PDF file from .tlf to stdout
  thinreports-template-cli help [COMMAND]            # Describe available commands or one specific command
  thinreports-template-cli info --layout=LAYOUT      # Display information for .tlf
```

```bash
$ thinreports-template-cli info --layout=~/template.tlf
```

```bash
$ thinreports-template-cli config --layout=~/template.tlf > config.yml
$ cat ~/config.yml
---
name: Taro Tottori
item: Toripy Plush Toy
price: 2980
```

```bash
$ thinreports-template-cli generate --layout=~/template.tlf --config=~/config.yml > example.pdf
```

```bash
$ thinreports-template-cli generate --layout=~/template.tlf --config=~/config.yml | lpr -P ApeosPort_V_C3375__aa_bb_cc_
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mh61503891/thinreports-template-cli.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
