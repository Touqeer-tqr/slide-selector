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

* Rename applitcation.css to applitcation.scss and add `@import "slide-selector.css";`
* In applitcation.js add `//= require slide-selector` after `//= require_tree .`

#### Syntax:

```
<%= slide_selector_tag [:min_field, :max_field], [:min_range, :max_range], options_for_select, options = {} %>
```

#### Options:

* `:slider_step` - To specify the size of each moment.
* `:type` - For dollar type use `'amount'`.
* `:selector` - To disable drop-down options (`options_for_select` can be nil for this).
* `:class` - Set class to div

#### Examples:
With form:
```
<%= form_for root_path do |f| %>
  <%= f.slide_selector [:min_rank, :max_rank], [0, 100], amount_drop_down_options, type: 'amount', selector: false, slider_step: 5 %>
  <br><br>
  <%= f.slide_selector [:min_rank2, :max_rank2], [0, 10000], simple_drop_down_options %>
<% end %>
```
Without form:
```
<%= slide_selector_tag [:min_rank3, :max_rank3], [0, 10000], simple_drop_down_options %>
```

In `application_helper.rb`
```
module ApplicationHelper
  def amount_drop_down_options
    {"$1" => 100, "$5" => 500, "$10" => 1000, "$25" => 2500, "$50" => 5000, "$75" => 7500, "$100" => 10000, "$250" => 25000, "$500" => 50000}
  end
  def simple_drop_down_options
    {"1" => 1, "50" => 50, "100" => 100, "200" => 200, "300" => 300, "400" => 400, "500" => 500, "1000" => 1000, "1500" => 1500, "2000" => 2000, "5000" => 5000}
  end
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/touqeer-tqr/slide-selector. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Slide::Selector project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/touqeer-tqr/slide-selector/blob/master/CODE_OF_CONDUCT.md).
