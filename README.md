[![Version](https://img.shields.io/gem/v/thinreports-template-cli.svg)](https://rubygems.org/gems/thinreports-template-cli)

# Thinreports Templete CLI

This command line tool is based on [Thinreports](https://rubygems.org/gems/thinreports).

## Installation

```sh
$ gem install thinreports-template-cli
```

## Usage

Thinreports Templete CLI is able to receive parameters of text blocks in a TLF (thinreports layout format) file as options of the command line program.

The command supports the following formats:

* table
* csv
* json
* pdf

```sh
$ thinreports-template-cli sample.tlf --help
thinreports-template-cli tlf [options]

Basic Options
        --format=table|csv|json|pdf

Thinreports Layout File Options
        --date=[DATE]                This is a sample date.
        --subject=[SUBJECT]          This is a sample subject.
        --name=[NAME]                This is a sample name.
        --number=[NUMBER]            This is a sample number.
        --date_jp=[DATE_JP]          This is a sample date for Japanese era name.
```

### Datetime Support

* A option value for a text block of a datetime format is parsed by [DateTime#parse](https://ruby-doc.org/stdlib/libdoc/date/rdoc/DateTime.html#method-c-parse).
* A text block of a datetime format is rendered by the strftime format of [DateTime#strftime](https://ruby-doc.org/stdlib/libdoc/date/rdoc/DateTime.html#method-i-strftime) and [era_ja](https://rubygems.org/gems/era_ja).
* If a text block of a datetime format does not have a command line option or a default value of a TLF file, this text block will be rendered with [Datetime#now](https://ruby-doc.org/stdlib/libdoc/date/rdoc/DateTime.html#method-c-now).

## Examples

Output to a PDF file.

```bash
$ thinreports-template-cli sample.tlf --name="Your name" --date=2017-04-01" --format=pdf > sample.pdf
```

Output to a printer via the lpr command.

```bash
$ thinreports-template-cli sample.tlf --name="Your name" --date=2017-04-01" --format=pdf | lpr -P ApeosPort_V_C3375__aa_bb_cc_
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Author

Masayuki Higashino
