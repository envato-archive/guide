# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog], and this project adheres to
[Semantic Versioning].

[Keep a Changelog]: https://keepachangelog.com/en/1.0.0/
[Semantic Versioning]: https://semver.org/spec/v2.0.0.html

## [Unreleased]

### Added

- Support `sprockets` version 4 ([#98]).

### Removed

- The `sass-rails` dependency is removed ([#99]).

[Unreleased]: https://github.com/envato/guide/compare/v0.6.1...HEAD
[#98]: https://github.com/envato/guide/pull/98
[#99]: https://github.com/envato/guide/pull/99

## [0.6.1] - 2021-06-10

### Fixed

- Custom javascript and CSS is included in HTML scenarios ([#97]).

[0.6.1]: https://github.com/envato/guide/compare/v0.6.0...v0.6.1
[#97]: https://github.com/envato/guide/pull/97

## [0.6.0] - 2021-06-09

### Added

- Add `actionpack` and `actionview` as explicit dependencies ([#94]).
  Previously, these were transitive dependencies.
- Record project metadata in the gem spec ([#96]).

### Changed

- CI build moved to run on GitHub Actions ([#91]).
- CI test suite runs against the latest versions of Nodejs, Ruby, and Rails
  ([#92]).

### Removed

- Removed support for Ruby 2.5 and lower ([#94]). Ruby 2.6 and higher is
  required.
- Removed support for Rails 5.1 and lower ([#94]). Rails 5.2 and higher is
  required.

### Fixed

- Fixed scenarios not rendering with Rails 6 ([#93]). Please ensure formats are
  specified using symbols when defining structures:

  ```diff
   def formats
  -  ['html', 'text']
  +  [:html, :text]
   end

   def layout_templates
     {
  -    'html' => 'layouts/my_html_layout',
  -    'text' => 'layouts/my_text_layout'
  +    html: 'layouts/my_html_layout',
  +    text: 'layouts/my_text_layout'
     }
   end
  ```

- Fixed links not using engine mount point ([#95]).
- The `README.md` file is included in the gem ([#96]).

[0.6.0]: https://github.com/envato/guide/compare/v0.5.0...v0.6.0
[#91]: https://github.com/envato/guide/pull/91
[#92]: https://github.com/envato/guide/pull/92
[#93]: https://github.com/envato/guide/pull/93
[#94]: https://github.com/envato/guide/pull/94
[#95]: https://github.com/envato/guide/pull/95
[#96]: https://github.com/envato/guide/pull/96

## [0.5.0] - 2021-03-25

### Added

- Move Buildkite CI configuration to code ([#86]).
- Relaxed `rails` dependency constraints ([#87]). Allow using version 6 or
  greater.

### Changed

- Replace `rails` dependency with dependency on `railties`, `activemodel`, and
  `sprockets-rails` ([#89]).

[0.5.0]: https://github.com/envato/guide/compare/v0.4.1...v0.5.0
[#86]: https://github.com/envato/guide/pull/86
[#87]: https://github.com/envato/guide/pull/87
[#89]: https://github.com/envato/guide/pull/89

## [0.4.1] - 2018-08-09

### Changed

- Replace `render text: 'plain text'` with `render plain: 'plain text'`
  ([#85]).

[0.4.1]: https://github.com/envato/guide/compare/v0.4.0...v0.4.1
[#85]: https://github.com/envato/guide/pull/85

## [0.4.0] - 2017-12-14

### Added

- Support for Rails 5 ([#82], [#83]):
  - Relax the dependency constraints to allow `rails` 5.x
  - Update the test suite to run against `rails` 4.2 and 5.1

[0.4.0]: https://github.com/envato/guide/compare/v0.3.2...v0.4.0
[#82]: https://github.com/envato/guide/pull/82
[#83]: https://github.com/envato/guide/pull/83

## [0.3.2] - 2017-03-26

### Removed

- Removed explicit support for Markdown ([#81]). Downstream applications can
  implement this if desired.

[0.3.2]: https://github.com/envato/guide/compare/v0.3.1...v0.3.2
[#81]: https://github.com/envato/guide/pull/81

## [0.3.1] - 2017-02-23

### Added

- First public release!

[0.3.1]: https://github.com/envato/guide/releases/tag/v0.3.1
