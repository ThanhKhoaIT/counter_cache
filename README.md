# Counter Cache for ActiveRecord

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'counter_cache'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install counter_cache

## Usage
In model file

Ex: `models/item.rb` file

```ruby
  belongs_to :list
  counter_cache :list
```
We will caching to `items_count` column in `lists` table

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ThanhKhoaIT/counter_cache. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CounterCache project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ThanhKhoaIT/counter_cache/blob/master/CODE_OF_CONDUCT.md).
