# Guide gem
Document your entire Rails application, not just its styles.

## Installation
TBD

## Configuration
TBD

## Maintainers

- [Luke Arndt](https://github.com/lukearndt)
- [Jordan Lewis](https://github.com/jordanlewiz)

## License

Guide uses the MIT license. See [LICENSE.txt](https://github.com/envato/guide/blob/master/LICENSE.txt) for details.

## Contributing

1. Fork it ( http://github.com/envato/guide/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

### Running test app
**Terminal**
- `bundle install`
- `cd spec/test_app`
- `rails s`

**Browser**
- `http://localhost:3000/guide/structures/friendly/example`

### JavaScript Assets

This app use `browserify` to bundle client-side JavaScript files.

To start adding new JavaScript file to the project, simply add it to `javascript/application.js`. Source code will be compiled to `app/assets/javascripts/guide/application` and load through `<%= javascript_include_tag "guide/application" %>`.

* `npm install` to install dependencies
* `npm run watch` to start live-reload watchify serer
* `npm run build` to build production assets(this is what being used and publish to the gem)
* `npm run lint` to fix javascript code styles
