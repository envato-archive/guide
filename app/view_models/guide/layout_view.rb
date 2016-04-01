class Guide::LayoutView
  attr_reader :active_node_visibility, :active_node_heritage, :active_node_title

  def initialize(bouncer:,
                 diplomat:,
                 content_node:,
                 active_node:,
                 active_node_heritage:,
                 active_node_visibility:,
                 active_node_title:,
                 authentication_system:,
                 injected_html:)
    @bouncer = bouncer
    @diplomat = diplomat
    @content_node = content_node
    @active_node = active_node
    @active_node_heritage = active_node_heritage
    @active_node_visibility = active_node_visibility
    @active_node_title = active_node_title
    @authentication_system = authentication_system
    @injected_html = injected_html
  end

  def active_node_name
    @active_node.name
  end

  def on_homepage?
    @active_node == @content_node
  end

  def injected_html
    @injected_html.html_safe
  end

  def paths_to_visible_renderable_nodes
    cartographer.draw_paths_to_visible_renderable_nodes(starting_node: @content_node)
  end

  def user_is_privileged?
    @bouncer.user_is_privileged?
  end

  def user_signed_in?
    @authentication_system.user_signed_in?
  end

  def url_for_sign_in
    @authentication_system.url_for_sign_in
  end

  def url_for_sign_out
    @authentication_system.url_for_sign_out
  end

  def supported_locales
    @diplomat.supported_locales
  end

  def show_locale_switcher?
    @bouncer.user_is_privileged? && @diplomat.multiple_supported_locales?
  end

  def current_locale
    @diplomat.current_locale
  end

  def locale_param
    'locale'
  end

  def show_image_logo?
    Guide.configuration.asset_path_for_logo.present?
  end

  private

  def cartographer
    @cartographer ||= Guide::Cartographer.new(@bouncer)
  end
end
