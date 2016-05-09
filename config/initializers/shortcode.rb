Shortcode.setup do |config|
  config.template_path = "#{Devx::Engine.root}/app/views/devx/shortcode_templates"
  config.block_tags = [ ]
  config.self_closing_tags = [ :slideshow ]
end

Shortcode.register_presenter(Devx::SlideshowPresenter)