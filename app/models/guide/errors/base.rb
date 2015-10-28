class Guide::Errors::Base < StandardError
  # This class exists so that we can tell the difference between an error
  # that is native to Guide and an error that has occurred
  # outside of our domain. All explictly thrown errors in Guide
  # should inherit from this.
end
