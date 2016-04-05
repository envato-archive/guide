# guide-gem
Document your application with a living component library and styleguide.

### Running test app
**Terminal**
- `bundle install`
- `cd spec/test_app`
- `rails s`

**Browser**
- `http://localhost:3000/guide/structures/friendly/example`

### JavaScript Assets

This app use `browserify` to bundle client-side JavaScript files.

To start add new JavaScript file to the project, simply add it to `javascript/index.js`. Source code will be compiled to `app/assets/javascripts/guide/bundle.js` and load throug `<%= javascript_include_tag "guide/application" %>`.

* `npm install` to install dependencies
* `npm run watch` to start live-reload watchify serer
* `npm run build` to build production assets(this is what being used and publish to the gem)
* `npm run lint` to fix javascript code styles
