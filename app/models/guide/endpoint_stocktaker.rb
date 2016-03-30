class Guide::EndpointStocktaker
  def initialize(starting_node:)
    @starting_node = starting_node
    @result = {}
  end

  def to_hash
    @result.tap do
      add_guide_content if @result.empty?
    end
  end

  private

  def add_guide_content
    renderable_nodes.keys.each do |node_path|
      node = monkey.fetch_node(node_path)
      if node.node_type == :structure
        add_structure(node_path: node_path, structure: node)
      else
        add_document(node_path: node_path)
      end
    end
  end

  def add_structure(node_path:, structure:)
    structure.scenarios.keys.each do |scenario_id|
      @result[endpoint_key(node_path, scenario_id: scenario_id)] = {
        "path" => url_helpers.scenario_path(
          :scenario_id => scenario_id,
          :scenario_format => :html,
          :node_path => node_path,
        )
      }
    end
  end

  def add_document(node_path:)
    @result[endpoint_key(node_path)] = { "path" => url_helpers.node_path(node_path) }
  end

  def endpoint_key(node_path, scenario_id: nil)
    [formatted_node_path(node_path), formatted_scenario_id(scenario_id)].compact.join('-')
  end

  def formatted_node_path(node_path)
    node_path.gsub('/', '.')
  end

  def formatted_scenario_id(scenario_id)
    scenario_id = scenario_id.to_s

    case scenario_id.length
    when 0
      nil
    when 1..50
      scenario_id.to_s
    else
      "#{scenario_id.first(24)}..#{scenario_id.last(24)}"
    end
  end

  def bouncer
    @bouncer ||= BribedBouncer.new
  end

  def cartographer
    Guide::Cartographer.new(bouncer)
  end

  def monkey
    @monkey ||= Guide::Monkey.new(@starting_node, bouncer)
  end

  def renderable_nodes
    cartographer.draw_paths_to_visible_renderable_nodes(starting_node: @starting_node)
  end

  def url_helpers
    Guide::Engine.routes.url_helpers
  end

  class BribedBouncer
    def user_can_access?(_)
      true
    end
  end
end
