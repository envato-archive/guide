class Guide::Content::Structures::Item::Support < Guide::Node
  contains :page
  contains :author_summary
  contains :contact_method
  contains :email_contact_modal
  contains :comment_contact_modal
  contains :purchase_codes
  contains :faqs
  contains :faq
  contains :add_faq
  contains :what_is_item_support_modal
  contains :launch_opt_out_modal, :visibility => :unpublished
end
