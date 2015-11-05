class Guide::Content::Structures::PurchaseFlow::ShoppingCart < Guide::Node
  contains :page
  contains :empty_cart
  contains :added_confirmation_modal
  contains :entry_edit_modal
  contains :configure_before_adding_modal
  contains :consistency_error
  contains :not_for_sale_error
end
