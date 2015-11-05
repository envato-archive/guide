class Guide::LayoutView
  attr_reader :active_node_visibility, :active_node_heritage, :active_node_title

  def initialize(bouncer:,
                 content_node:,
                 active_node:,
                 active_node_heritage:,
                 active_node_visibility:,
                 active_node_title:)
    @bouncer = bouncer
    @content_node = content_node
    @active_node = active_node
    @active_node_heritage = active_node_heritage
    @active_node_visibility = active_node_visibility
    @active_node_title = active_node_title
  end

  def active_node_name
    @active_node.name
  end

  def on_homepage?
    @active_node == @content_node
  end

  def paths_to_visible_renderable_nodes
    cartographer.draw_paths_to_visible_renderable_nodes(starting_node: @content_node)
  end

  def show_locale_switcher?
    #TODO: Add Diplomat
    false
  end

  def user_is_staff?
    @bouncer.user_is_staff?
  end

  def user_signed_in?
    @bouncer.user_signed_in?
  end

  private

  def cartographer
    @cartographer ||= Guide::Cartographer.new(@bouncer)
  end
end
