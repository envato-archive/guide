module Guide
  class Content < Document
    # Tip: Ordering determines the nav position
    contains :documents
    contains :structures
  end
end
