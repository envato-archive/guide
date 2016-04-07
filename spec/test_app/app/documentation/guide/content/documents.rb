class Guide::Content::Documents < Guide::Document
  contains :public
  contains :unpublished, visibility: :unpublished
  contains :restricted, visibility: :restricted
end
