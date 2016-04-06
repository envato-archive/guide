# Guide gem
Document your entire Rails application, not just its styles.

## Development Status [![Build status](https://badge.buildkite.com/277fd82c44a19eb19ac9a25a71df482cb7711c63ddf9bca3d3.svg)](https://buildkite.com/envato-marketplaces/guide)
Guide is extracted from production code in use at Envato. However, it is undergoing early development, and APIs and features are almost certain to be in flux.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'guide'
```

And then execute:
```shell
$ bundle install
```

## Configuration

### Step 1: Add config file
Add `/config/initializers/guide.rb`

Example
```Ruby
Guide.configure do |config|
  config.asset_path_for_logo = "guide/envato-market-styleguide.svg"
  config.company_name = "Envato"
  config.controller_class_to_inherit = "Guide::ControllerInjection"
  config.default_stylesheets_for_structures = ['market/core/index', 'market/pages/default/index']
  config.guide_name = "Envato Market Guide"
  config.helper_module_to_globally_include = 'Guide::HelperInjection'
  config.local_variable_for_view_model = :view_model
  config.supported_locales = {
    "English" => "en",
    "Portuguese" => "pt",
    "Spanish" => "es",
  }
end
```

### Step 2: Build your Guide(s)
All your Guides and content will live in `app/documenation/guide/content`

For now these folders and files will need to be created manually

Add `app/documenation/guide/content.rb` and define your Guide.

Example
``` Ruby
class Guide::Content < Guide::Document
  contains :ui_library
  contains :structures
  contains :branding
end
```

#### Navigation
A Guide's navgivation is essentially a tree of nodes with pages that are either a `Document` or a `Structure`.

- `Guide::Node` for organising things in the tree without adding pages
- `Guide::Document` for static pages
- `Guide::Structure` for dynamic pages with scenarios

##### Node
> A node is a point on the content tree. Everything in the content folder is a node.

Example
```Ruby
class Guide::Content::UILibrary::Typography < Guide::Node
  contains :body
  contains :currency
  contains :heading
  contains :link
  contains :list
  contains :preformatted
end
```

##### Document
> This type of node has no scenarios, but is still renderable. It corresponds to a static template, usually with the same name, in the same folder.

Example

`app/documentation/guide/content/ui_library/typography/heading.rb`
```Ruby
class Guide::Content::UILibrary::Typography::Heading < Guide::Document
end
```

`app/documentation/guide/content/ui_library/typography/heading.html`
```HTML
<div>whatever you like</div>
```

##### Structure
> This type of node can manage a list of scenarios, so that we can render a piece of the UI as it would look in lots of different situations.

**Supported format**
- `html`
- `text`
- `markdown` (coming soon)

Example
`app/documentation/guide/content/structures/account/sign_in_modal.rb`
```Ruby
class Guide::Content::Structures::Account::SignInModal < Guide::Structure
  def partial
    'sso/sign_in/modal'
  end

  def layout_css_classes
    {
      :parent => 'js',
      :scenario => '-layout-modal'
    }
  end

  private

  def view_model(options = {})
    Guide::ViewModel.new(
      {
        :form => Guide::FormObject.new,
        :user_action => :checkout,
      }, options
    )
  end

  # Scenarios

  scenario :user_clicks_sign_in do
    view_model(
      :user_action => :direct
    )
  end

  scenario :user_wants_to_checkout do
    view_model(
      :user_action => :checkout
    )
  end
end
```

#### Scenarios
TODO: Elaborate

#### Homepage
The homepage of your Guide is a special snowflake. Edit the contents here.
`app/documenation/guide/_content.html.erb`


#### Fixtures
Fxitures are reusable data for your Components. They can be defined once and then reused and overrided in different components and scenarios.

Tip: Try to folder your fixtures to match your models.

`app/documenation/guide/fixtures.rb` (required if you want to use fixtures)
`app/documenation/guide/fixtures/` (all fixtures go in here)

Example
```Ruby
# app/documentation/guide/fixtures/common.rb

class Guide::Fixtures::Common < Guide::Fixture
  def self.alert_box_view_model(options = {})
    Guide::ViewModel.new(
      {
        :type => :notice,
        :message => "You need to set a message",
      }, options
    )
  end
end
```

### Injections (optional)
Injections can be used to supply app specific code

`controller_injection.rb` (main)
`authentication_system_injection.rb`
`authorisation_system_injection.rb`
`helper_injection.rb`
`html_injection.rb`

### Permissions
It is possible to restrict access to a Document, Structure or even at the Scenario level.
The 3 types of access are `public`, `unpublished` and `restricted`. Access depends on setting up your authorisation and authentication system.

Example
``` Ruby
class Guide::Content < Guide::Document
  contains :structures # public by default
  contains :ui_library, :visibility => :unpublished
  contains :branding, :visibility => :restricted
end
```

### Authorisation
TODO

### Authentication
TODO

## Cucumbers
TODO

### Consistency Specs
These specs ensure that your fake view models (Guide::ViewModel) in Guide have the same public interfaces as the real view models in your application
`spec/documentation/guide/content`

### Step 3: Access your Guide(s)
When you mount the gem in your routes file, you can specify a route to mount it to. If you want it mounted at the root of your application, you'd use:

```ruby
mount Guide::Engine => "/"
```

Or if you want it at, say, `/guide/`, you could use:

```ruby
mount Guide::Engine => '/guide/'
```

Any routes defined by the Guide gem will be prefixed with the path you specify when you mount it.

## Maintainers
- [Luke Arndt](https://github.com/lukearndt)
- [Jordan Lewis](https://github.com/jordanlewiz)

## License
Guide uses the MIT license. See [LICENSE.txt](https://github.com/envato/guide/blob/master/LICENSE.txt) for details.

## Contact
- [github project](https://github.com/envato/guide)
- Bug reports and feature requests are via [github issues](https://github.com/envato/guide/issues)

## Code of conduct
We welcome contribution from everyone. Read more about it in
[`CODE_OF_CONDUCT.md`](https://github.com/envato/guide/blob/master/CODE_OF_CONDUCT.md)

## Contributing
1. Fork it ( http://github.com/envato/guide/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

For larger new features: Do everything as above, but first also make contact with the project maintainers to be sure your change fits with the project direction and you won't be wasting effort going in the wrong direction

Please see the [Wiki](https://github.com/envato/guide/wiki) for indepth instructions on developing and understanding the Guide gem.
