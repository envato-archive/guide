class Guide::NodeView
  delegate :id,
    :options,
    :name,
    :formats,
    :cell,
    :template,
    :layout_css_classes,
    :node_type,
    :can_be_rendered?,
    :view_model, :to => :@node

  attr_reader :node_path

  def initialize(node:, bouncer:, diplomat:, node_path:)
    @node = node
    @bouncer = bouncer
    @diplomat = diplomat
    @node_path = node_path
  end

  def visible_scenarios
    @node.scenarios.select do |scenario_id, scenario|
      @bouncer.user_can_access?(scenario)
    end
  end

  def multiple_formats?
    @node.formats.size > 1
  end

  def uses_cells?
    cell.present?
  end

  def template_location
    template || cell
  end

  def user_is_privileged?
    @bouncer.user_is_privileged?
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
    'temp_locale'
  end
end
