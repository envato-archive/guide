module Guide::DocumentHelper
  def code_example(language='markup', show_rendered_element=true, &block)
    raise ArgumentError, "Missing block" unless block_given?

    code_stream = capture(&block)

    html = Nokogiri::HTML(code_stream.to_str)
    code_string = html.css("span.example").collect(&:inner_html).join
    code_string = code_stream.to_str if code_string.blank?

    code_string = code_string.strip_heredoc.strip

    capture do
      concat content_tag(:div, code_stream, :class => "sg-content__demo") if show_rendered_element
      concat content_tag(:pre, content_tag(:code, code_string),
                         :class => "sg-content__code language-#{language} line-numbers",
                         :"data-language" => language)
    end
  end
end
