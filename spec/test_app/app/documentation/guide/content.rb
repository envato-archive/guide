class Guide::Content < Guide::Document
  # Tip: Ordering determines the nav position
  contains :documents
  contains :structures
end
