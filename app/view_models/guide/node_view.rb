class Guide::NodeView
  delegate :id,
    :options,
    :name,
    :partial,
    :formats,
    :cell,
    :template,
    :custom_show_partial,
    :layout_css_classes,
    :node_type,
    :can_be_rendered?, :to => :@node

  attr_reader :node_path

  def initialize(node:, bouncer:, node_path:)
    @node = node
    @bouncer = bouncer
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

  def show_locale_switcher?
    #TODO: Add Diplomat
    false
  end

  def template_location
    template || cell || partial
  end

  def user_is_staff?
    @bouncer.user_is_staff?
  end
end
