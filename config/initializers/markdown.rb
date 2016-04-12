require 'github/markup'
require 'rdiscount'

class ActionView::Template
  module Handlers
    class Markdown
      def self.call(template)
        markdown = GitHub::Markup.render('README.markdown', template.source)
        "%{<div class='#{Guide.configuration.markdown_wrapper_class}'>#{markdown}</div>}.html_safe"
      end
    end
  end

  register_template_handler :md, Handlers::Markdown
end
