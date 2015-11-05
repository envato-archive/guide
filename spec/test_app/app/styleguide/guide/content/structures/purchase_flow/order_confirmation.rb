class Guide::Content::Structures::PurchaseFlow::OrderConfirmation < Guide::Node
  contains :page
  contains :order_summary
  contains :mid_purchase, :visibility => :unpublished
  contains :studio_banner, :visibility => :unpublished
end
