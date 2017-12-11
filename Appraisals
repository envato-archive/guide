%w[
  4.2.10
].each do |rails_version|
  ENV['APPRAISAL_RAILS_VERSION'] = rails_version
  appraise("rails-#{rails_version}") { gem 'rails', rails_version }
end
