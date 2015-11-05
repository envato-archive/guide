class Guide::Content::Structures::User::Downloads < Guide::Node
  contains :page
  contains :download
  contains :sidebar
  contains :license_certificate, :visibility => :unpublished
end
