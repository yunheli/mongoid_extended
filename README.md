# MongoidExtended

[![Build Status](https://travis-ci.org/NaixSpirit/mongoid_extended.svg?branch=develop)](https://travis-ci.org/NaixSpirit/mongoid_extended)
[![Code Climate](https://codeclimate.com/github/NaixSpirit/mongoid_extended/badges/gpa.svg)](https://codeclimate.com/github/NaixSpirit/mongoid_extended)
[![Test Coverage](https://codeclimate.com/github/NaixSpirit/mongoid_extended/badges/coverage.svg)](https://codeclimate.com/github/NaixSpirit/mongoid_extended/coverage)
[![Gem Version](https://badge.fury.io/rb/mongoid_extended.svg)](https://badge.fury.io/rb/mongoid_extended)

Mongoid extended, Support EpochTime, ObjectId, Serializer, SoftDelete

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mongoid_extended'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongoid_extended

## Usage

```ruby
require 'mongoid_extended'

MongoidExtended.configure :EpochTime, :ObjectId, :Serializer, :SoftDelete
```

### EpochTime

```ruby
MongoidExtended.configure :EpochTime

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :locked_at, type: DateTime, default: -> { Time.now.utc }
end

user = User.create
#<User _id: 5614eb9b908c4f0828000007, created_at: 2015-10-07 09:53:31 UTC, updated_at: 2015-10-07 09:53:31 UTC, locked_at: 2015-10-07 09:53:31 UTC>

user.created_at # => 1444211611
user.updated_at # => 1444211611
user.locked_at  # => 1444211611
```

### ObjectId

```ruby
MongoidExtended.configure :ObjectId

User.create.to_json

{
  "_id": "5614eb9b908c4f0828000007"
}
```

### Serializer

```ruby
# add active_model_serializers support for mongoid
MongoidExtended.configure :Serializer
```

### SoftDelete

```ruby
MongoidExtended.configure :SoftDelete

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include MongoidExtended::SoftDelete
end

@user = User.create
@user.destroy
@user.deleted? # => true
@user.deleted_at # => 2015-10-07 18:09:19 +0800
@user.touch  # => RuntimeError, can't modify frozen Hash

User.count # => 1
User.undeleted.count # => 0
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/NaixSpirit/mongoid_extended. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

