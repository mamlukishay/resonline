# Resonline

This gem created according to resonline documentation http://api-pvt.resonline.com.au/direct/2.0/documentation/

## Installation

Add this line to your application's Gemfile:

    gem 'resonline'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install resonline

## Usage

NOTE: Still in development

Implemented method:

- `Resonline::Inventory.get_rate_packages`
- `Resonline::Inventory.get_inventory(start_date, end_date, rate_package_ids = [])`
- `Resonline::Service.get_hotel_rooms`
- `Resonline::Service.get_hotel_rate_package_deals(rate_package_id)`
- `Resonline::Transformation.get_availability(room_id, start_date, end_date)`
- `Resonline::Transformation.set_availability(room_id, start_date, end_date, number_available)`

## Configuration

Add an initializer e.g config/initializers/resonline.rb

```ruby
Resonline.configure do |config|
  config.cm_username = 'Username for login to channel manager'
  config.cm_password = 'Password for login to channel manager'
  config.username = 'Username to access SOAP'
  config.password = 'Password to access SOAP'
  config.hotel_id = 'Hotel id connected to your account'
end
```