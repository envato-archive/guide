require 'rdiscount'

module ActionView
  module Template::Handlers
    class Markdown
      def self.call(template)
        compiled_source = erb.call(template)
        "RDiscount.new(begin;#{compiled_source};end).to_html.html_safe"
      end

      def self.erb
        @erb ||= ActionView::Template.registered_template_handler(:erb)
      end
      private_class_method :erb
    end
  end
end

ActionView::Template.register_template_handler :md, ActionView::Template::Handlers::Markdown
