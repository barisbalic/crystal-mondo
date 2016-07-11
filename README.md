# crystal-monzo
[![crystal-docs.org](https://crystal-docs.org/badge.svg)](https://crystal-docs.org/barisbalic/crystal-monzo) 

A [Crystal](https://crystal-lang.org) client for the [Monzo API](https://monzo.com/docs/).

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  crystal-monzo:
    github: barisbalic/crystal-monzo
```

## Usage

```crystal
require "monzo"

client = Monzo.new("SATSUI-NO-HADOU")
client.accounts.each do |account|
  balance = client.balance(account)
  puts balance.spend_today
end
```

The client API follows the documented API reasonably closely, the only significant divergence being that the "who_am_i"
calls are made with `client.identity`.  Only because "who_am_i" really annoyed me.

## Development

In order to run the tests you will need to set the `MONZO_TOKEN` environment variable to a valid API token.  You can
then run the tests with:

```sh
MONZO_TOKEN=magicbeans crystal spec
```

## Contributing

1. Fork it ( https://github.com/barisbalic/crystal-monzo/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [barisbalic](https://github.com/barisbalic) Baris Balic - creator, maintainer
