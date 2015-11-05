class Guide::Content::Structures::PurchaseFlow::Email < Guide::Node
  contains :order_confirmation
  contains :mid_purchase_email_verification, :visibility => :unpublished
  contains :refund_request_received, :visibility => :unpublished
end
