class Guide::BaseController < Guide.configuration.controller_class_to_inherit.constantize
  private

  def authorisation_system
    # Override this method if you need to pass arguments into whatever
    # implementation of Guide::AuthorisationSystem works for your application
    @authorisation_system ||= Guide::AuthorisationSystem.new
  end

  def active_node
    @node ||= monkey.fetch_node(node_path)
  end

  def bouncer
    @bouncer ||= Guide::Bouncer.new(authorisation_system)
  end

  def content
    @content ||= Guide::Tree.root
  end

  def monkey
    Guide::Monkey.new(content, bouncer)
  end

  def nobilizer
    Guide::Nobilizer.new
  end

  def active_node_visibility
    Guide::Scout.new(content).visibility_along_path(node_path)
  end

  def node_path
    params[:node_path] || ""
  end

  def raise_error_in_dev_else_404(error)
    if Rails.env.development?
      raise error
    else
      render_404
    end
  end

  def render_404
    render :text => 'Not Found', :status => '404'
  end
end
