module Guide
  class Content::Documents < Document
    contains :public
    contains :unpublished, visibility: :unpublished
    contains :restricted, visibility: :restricted
  end
end
