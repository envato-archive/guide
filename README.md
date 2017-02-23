# Guide gem
Document your entire user interface, not just your styles.

# Features

- Create a component library using real templates from your application
- Organise your components into a dynamic tree structure
- Fake out your backend at the view model layer
- See what each template looks like when you vary the data it receives

## Development Status [![Build status](https://badge.buildkite.com/277fd82c44a19eb19ac9a25a71df482cb7711c63ddf9bca3d3.svg)](https://buildkite.com/envato-marketplaces/guide)
Guide runs in production at [Envato](https://market.styleguide.envato.com). While it is moderately mature at this stage, its API and features are still subject to changes.

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
Add `/config/initializers/guide.rb`

```Ruby
# Available options with example usage

Guide.configure do |config|
  config.asset_path_for_logo = "guide/aweosme-guide-logo.svg"
  config.company_name = "Your Awesome Company"
  config.controller_class_to_inherit = "Guide::ControllerInjection"
  config.default_stylesheets_for_structures = ['application/core/index', 'application/pages/default/index']
  config.guide_name = "Your Awesome Guide"
  config.helper_module_to_globally_include = 'Guide::HelperInjection'
  config.local_variable_for_view_model = :view_model
  config.markdown_wrapper_class = 'markdown'
  config.supported_locales = {
    "English" => "en",
    "Portuguese" => "pt",
    "Spanish" => "es",
  }
end
```

**Note:** If you are having asset compiling issues you may need to add Guide's assets to your asset precompile config e.g.

```Ruby
# config/application.rb

config.assets.precompile += [
  'guide/application.js',
  'guide/scenario.js',
  'guide/application.css',
  'guide/scenario.css'
]
```


## Build your Guide(s)

### Architecture & Navigation

Each Guide is essentially a tree of nodes with pages that are either a `Document` or a `Structure`.

- Use `Node` for organising things in the tree without adding pages
- Use `Document` for static pages
- Use `Structure` for dynamic pages with scenarios. Each `Structure` represents a template in your application.

`content.rb` is the root node of that tree and defines your top level navigation structure.
To add child nodes, use the following DSL:

`contains :child_node_name`

This example declares that the tree contains a child node named:

`Guide::Content::ChildNodeName`

You will need to create a class for it.

All of your content should live in the `Guide::Content` namespace so that Guide can find it easily.

Feel free to redeclare the base node class in your system at the following path:

`app/<whatever_you_want>/guide/content.rb`

It needs to be a `Document` or a `Structure`, otherwise your Guide will not have a working homepage.

The convention for the subdirectory in app/ is `documentation`,
but if you don't like that, you can use something else.

We don't recommend putting it inside the standard rails directories though.

Here's an example of what `app/documentation/guide/content.rb` might look like:

``` Ruby
# app/documentation/guide/content.rb

class Guide::Content < Guide::Document
  contains :structures
  contains :ui_library
  contains :branding
end
```

To specify options such as visibility, append them to the declaration:

```Ruby
contains :structures  # no visbility specified = public
contains :ui_library, :visibility => :unpublished
contains :branding, :visibility => :restricted
```

### Node
> A node is a point on the content tree. Everything in the content folder is a node.

```Ruby
# app/documentation/guide/ui_library/typography

class Guide::Content::UILibrary::Typography < Guide::Node
  contains :body
  contains :currency
  contains :heading
  contains :new_experiment, :visibility => :unpublished
  contains :link
  contains :list
  contains :preformatted
end
```

### Document
> This type of node has no scenarios, but is still renderable. It corresponds to a static template, usually with the same name, in the same folder.

**Supported formats**
- `html`
- `text`
- `markdown`

```Ruby
# app/documentation/guide/content/ui_library/typography/heading.rb

class Guide::Content::UILibrary::Typography::Heading < Guide::Document
end
```

`app/documentation/guide/content/ui_library/typography/heading.html`
```HTML
<div><p>Whatever you like!</p></div>
```

### Structure
> This type of node can manage a list of Scenarios, so that we can render a piece of the UI as it would look in lots of different situations.

For more info on how to add Structures and Scenarios, see the [wiki](https://github.com/envato/guide/wiki/Adding-Structures)

### Scenario
> Each Scenario represents a set of data passed into the template via its view model. These let us see what our templates look like under various conditions.

### Homepage
The homepage of your Guide is a special snowflake. Edit the contents here:
`app/documentation/guide/_content.html.erb`


## Advanced setup
### Linking

In order to link to other Guide pages from within your content, you will need to use the `node_path` url helper. Here are a couple of examples:

```Ruby
<%= link_to "root level link", Guide::Engine.routes.url_helpers.node_path('documents') %>
<%= link_to "nested link", Guide::Engine.routes.url_helpers.node_path('documents/restricted') %>
```

### Fixtures
Fixtures are reusable data for your Structures. They can be defined once and then reused across multiple structures and scenarios.

Tip: Try to organise your fixtures in a similar way to your real view models.

Guide defines the `Guide::Fixtures` module, so if your put your fixtures in `app/documentation/guide/fixtures/` they should be autoloaded correctly.

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

### Injections
Injections can be used when you need to supply code to help Guide work within the context of your application.


#### Controller base class

Guide allows you to push code directly into its controllers through dependency injection. You will need to do this to be able to use most of the other code injections that Guide supports, as you'll see a bit later on.

When configuring Guide, one of the options available to you is to specify a `controller_class_to_inherit`. This does what it says. Think of it like an ApplicationController, but specific to your Guide.

The class that you supply needs to be a Rails controller, so you'll need to inherit from `ActionController::Base`.

If you choose to use this feature, remember to use unique method names. It may be helpful to take a glance at the code for Guide's controllers to make sure that you haven't got any clashes.

```Ruby
# Controller base class injection

Guide.configure do |config|
  config.controller_class_to_inherit = "Guide::ControllerInjection"
end

class Guide::ControllerInjection < ActionController::Base
  # Your code here
end
```

#### Authentication system

Unless you're running a totally public Guide, you will need some way to determine who is viewing it so that you can choose what they are allowed to see.

Since the means of authentication varies across different applications, Guide allows you to pass in an authentication system instead of providing its own.

If you inject an authentication system, Guide will call the `#user_signed_in?`, `#url_for_sign_in` and `#url_for_sign_out` methods on it. It's recommended that you inherit from `Guide::DefaultAuthenticationSystem`.

Here's an example of how you might set this up:

```Ruby
# Authentication system injection

class Guide::ControllerInjection < ActionController::Base
  private

  def authentication_system
    Guide::AuthenticationSystemInjection.new(request)
  end
end

class Guide::AuthenticationSystem < Guide::DefaultAuthenticationSystem
  def initialize(request)
    @request = request
  end

  def user_signed_in?
    RealAuthenticationSystemForYourApplication.new(request).signed_in?
  end

  def url_for_sign_in
    # Where do you want to send people when they click the 'sign in' link?
  end

  def url_for_sign_out
    # This is where people will end up when they click 'sign out'
  end
end
```

#### Authorisation system

Once you've figured out who is looking at your Guide, you're ready to decide what they're allowed to see.

As with the authentication system, most applications have some way of determining this sort of thing. Instead of presuming to know how your system works, Guide lets you implement this yourself.

If you inject an authorisation system, Guide will call the `#allow?(action)`, `#user_is_privileged?` and `#valid_visibility_options` methods on it. Inheriting from `Guide::DefaultAuthorisatinSystem` will get you some sensible defaults for the latter two of these methods.

You can set this up however you like, as long as you hook into the controller via `#authorisation_system` and implement the `#allow?(action)` method. Here's an example of how you might do it:

```Ruby
# Authorisation system injection

class Guide::ControllerInjection < ActionController::Base
  private

  def authorisation_system
    Guide::AuthorisationSystemInjection.new(real_authorisation_system)
  end

  def real_authorisation_system
    RealAuthorisationSystemForYourApplication.new(signed_in_user)
  end
end

class Guide::AuthorisationSystemInjection < Guide::DefaultAuthorisationSystem
  def initialize(real_system)
    @real_system = real_system
  end

  def allow?(action)
    if Rails.env.development?
      true
    else
      @real_system.allow?(action)
    end
  end

  # Optional methods for if you want to use custom visibility options

  def user_is_privileged?
    allow?(:view_guide_not_ready_yet) ||
      allow?(:view_guide_top_secret_feature)
  end

  def valid_visibility_options
    [
      nil,
      :not_ready_yet,
      :restricted,
    ]
  end
end
```

#### HTML Injection

If you would like to push some HTML directly onto every page in Guide, you can do so using an HTML injection.

A good example of HTML that you might like to inject is a stylesheet link tag:

```Ruby
# HTML injection for a stylesheet link tag

class Guide::ControllerInjection
  private

  def html_injection
    Guide::HtmlInjection.new.prepare_injection(view_context)
  end
end

class Guide::HtmlInjection
  include ActionView::Helpers::AssetTagHelper

  def prepare_injection(view_context)
    [
      view_context.stylesheet_link_tag("application/core/index"),
    ].join(" ")
  end
end
```

#### Helper Injection

While the Guide development team recommends the use of view models instead of helpers, sometimes you're working on an application that already relies on them. Guide allows you to inject helpers so that you can get started without first having to retire them all.

Here's how to do it:

```Ruby
# Injecting helper modules

Guide.configure do |config|
  config.helper_module_to_globally_include = "Guide::HelperInjection"
end

module Guide::HelperInjection
  include ::RegretHelper
  include ::SoonToBeRetiredHelper
end
```

If you _really_ need to, you can add `include ::ApplicationHelper` to this list.

## Browser tests
Guide does not come packaged with browser tests, but it's a great idea to write some. Here's an example of how you might create one:

```ruby
  content = Guide::Content.new
  authorisation_system = Guide::DefaultAuthorisationSystem.new
  bouncer = Guide::Bouncer.new(authorisation_system: authorisation_system)
  cartographer = Guide::Cartographer.new(bouncer)

  cartographer.draw_paths_to_visible_renderable_nodes(starting_node: content).each do |node_path, node_title|
    aggregate_failures do
      begin
        visit Guide::Engine.routes.url_helpers.node_path(:node_path => node_path)
        with_scope('.sg-header') do
          expect(page).to have_content("<put something recognisable here>")
        end
        puts "Successfully visited #{node_title}"
      rescue StandardError, RSpec::Expectations::ExpectationNotMetError => e
        raise [
          "Could not load the guide page for #{node_path},",
          "To open this in your browser, visit <Root path to your guide>/#{node_path}",
          "You can find the file for this at app/documentation/guide/content/#{node_path}.rb",
          "Here's what I saw when I tried to go there:",
          "#{e.message}",
          "#{page.body.split('Full backtrace').first}",
        ].join("\n\n")
      end
    end
  end
```

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

## Maintainer
- [Luke Arndt](https://github.com/lukearndt)

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

For larger new features: do everything as above, but first also make contact with the project maintainers to be sure your change fits with the project direction and you won't be wasting effort going in the wrong direction.

Please see the [Wiki](https://github.com/envato/guide/wiki) for indepth instructions on developing and understanding the Guide gem.
