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

For example models

**Item model**: `models/item.rb` 
```ruby
  class Item < ActiveRecord::Base
  
    belongs_to :list
    
    scope :published, -> { where(status: :published) }
  
  end
```


#### Basic

```ruby
  belongs_to :list
  counter_cache :list
```
Or by **ActiveRecord** supported
```ruby
  belongs_to :list, counter_cache: true
```

We will caching to `items_count` column in `lists` table

#### Advanced
##### With scope option
- By model scopes
```ruby
  counter_cache :list, scope: :published
```

- By where hash
```ruby
  counter_cache :list, scope: { status: :published }
```

- By where string
```ruby
  counter_cache :list, scope: "status = 'published'"
```

##### With column option
- Set column name to caching
```ruby
  counter_cache :list, column: :custom_name
```
**Default** column name to cached is append `_count` to self table name

> => items + _count


##### With column vs scope options

```ruby
  counter_cache :list, scope: :published, column: :published_items_count
```

- Multiple caching
```ruby
  counter_cache :list, scope: :published, column: :published_items_count
  counter_cache :list, scope: { status: :rejected }, column: :rejected_items_count
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ThanhKhoaIT/counter_cache. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CounterCache project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ThanhKhoaIT/counter_cache/blob/master/CODE_OF_CONDUCT.md).
