# Custom Range Selector

[![N|Solid](https://raw.githubusercontent.com/Touqeer-tqr/slide-selector/master/vendor/assets/images/range-selector.png)]()

## Details
Sample app about how to create custom input tags for form
custom input tag that adds range slider with selector in which you can also enter text and slider will auto adjust.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slide-selector'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install slide-selector

## Usage

Rename applitcation.css to applitcation.scss and add `@import "slide-selector.css";`
In applitcation.js add `//= require slide-selector` after `//= require_tree .`

Some examples of using this tag
With form:
```
<%= form_for root_path do |f| %>
  <%= f.slide_selector [:min_rank, :max_rank], [0, 100], drop_down_options_dollar, type: 'amount', selector: false, slider_step: 5 %>
  <br><br>
  <%= f.slide_selector [:min_rank2, :max_rank2], [0, 10000], drop_down_options %>
<% end %>
```
Without form:
```
<%= slide_selector_tag [:min_rank3, :max_rank3], [0, 10000], drop_down_options %>
```

In application_helper.rb
```
module ApplicationHelper
  def drop_down_options
    {"$0.01" => 1, "$0.50" => 50, "$1" => 100, "$2" => 200, "$3" => 300, "$4" => 400, "$5" => 500, "$10" => 1000, "$15" => 1500, "$25" => 2500, "$50" => 5000, "$75" => 7500, "$100" => 10000}
  end
  def drop_down_options2
    {"1" => 1, "50" => 50, "100" => 100, "200" => 200, "300" => 300, "400" => 400, "500" => 500, "1000" => 1000, "1500" => 1500, "2500" => 2500, "5000" => 5000, "7500" => 7500, "10000" => 10000}
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/touqeer-tqr/slide-selector. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Slide::Selector project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/touqeer-tqr/slide-selector/blob/master/CODE_OF_CONDUCT.md).
