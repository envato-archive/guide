class Guide::Content::Structures < Guide::Document
  contains :level_one
  contains :account, :visibility => :restricted
  contains :item
  contains :layout
  contains :purchase_flow
  contains :static_pages
  contains :user, :visibility => :unpublished
end
