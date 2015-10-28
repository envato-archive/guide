class Guide::Content < Guide::Document
  # The content in the Living Styleguide for your application is organised
  # into a tree structure. This class is the root node of that tree.
  # To add child nodes, use the following DSL:
  #
  # contains :child_node_name
  #
  # This example declares that the tree contains a child node named:
  #
  # Guide::Content::ChildNodeName
  #
  # You will still need to create a class for it.
  #
  # It is highly recommended that all of your content lives in the
  # Guide::Content namespace or Guide will have trouble finding it!
  #
  # To specify options such as visibility, append them to the declaration:
  #
  # contains :child_node_name, :visibility => :unpublished
  #
  # Feel free to redeclare this class in your system at the following path:
  #
  # app/<whatever_you_want>/guide/content.rb
  #
  # The convention for the subdirectory in app/ is "styleguide",
  # but if you don't like that, you can use something else (even "models"!).
  # You probably shouldn't use any other standard rails directories though.
end
