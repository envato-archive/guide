class Guide::Content::Structures::PurchaseFlow::Checkout < Guide::Node
  contains :page_signed_in
  contains :page_signed_out, :visibility => :unpublished
  contains :breadcrumb, :visibility => :unpublished
  contains :create_account, :visibility => :unpublished
  contains :billing_details
  contains :payment_method
  contains :payment_method_credit_cards_enabled, :visibility => :unpublished
  contains :review_order
  contains :order_summary
  contains :deposit_and_buy_modal
  contains :retry_purchase
  contains :financial_institutes
end
