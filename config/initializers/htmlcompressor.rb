module Devx
  module Compressor
    def self.compress(content)
      options = {
        :enabled => true,
        :remove_multi_spaces => true,
        :remove_comments => true,
        :remove_intertag_spaces => false,
        :remove_quotes => false,
        :compress_css => true,
        :css_compressor => :yui,
        :compress_javascript => true,
        :javascript_compressor => :yui,
        :simple_doctype => false,
        :remove_script_attributes => false,
        :remove_style_attributes => false,
        :remove_link_attributes => false,
        :remove_form_attributes => false,
        :remove_input_attributes => false,
        :remove_javascript_protocol => false,
        :remove_http_protocol => false,
        :remove_https_protocol => false,
        :preserve_line_breaks => false,
        :simple_boolean_attributes => false,
        :compress_js_templates => false
      }

      compressor = HtmlCompressor::Compressor.new(options)
      compressor.compress(content)
    end
  end
end