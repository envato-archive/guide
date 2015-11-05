class Guide::Content::Structures::PurchaseFlow < Guide::Node
  contains :checkout
  contains :email
  contains :order_confirmation
  contains :refund_requests, :visibility => :unpublished
  contains :shopping_cart
end
