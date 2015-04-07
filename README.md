## Skipit Publisher
APN and Faye publishing for Skipit

## Installation

```ruby
gem 'skipit_publisher', :git=>'https://github.com/iiwo/skipit_publisher.git'
```
Run the bundle command to install it.

After you install Publisher and add it to your Gemfile, you need to run the generator:

```console
rails generate skipit_publisher:install
```

## Configuration

add this to Procfile:
```ruby
rpush: bundle exec rpush start -e $RACK_ENV -f
```
## Example usage

```ruby
          SkipitPublisher::Publisher.publish('app_name','this is a test message',
                  { :ios => 'af826ab01bfc170b7ffd967da099aff5e52a56a79e6209fcfbf6d8803acbc986',
                    :faye =>'user_123', :email =>'test@test.com'},
                  { user_id: 123 }
          )
```