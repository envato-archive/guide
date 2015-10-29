class Guide::Nobilizer
  def bestow_title(node_path)
    node_path.split("/").collect(&:titleize).join(" » ").html_safe
  end

  def bestow_heritage(node_path)
    node_path.split("/")[0...-1].collect(&:titleize).join(" » ").html_safe
  end
end
