class Guide::Content::Structures::User < Guide::Node
  contains :downloads
  contains :uploads, :visibility => :unpublished
end
