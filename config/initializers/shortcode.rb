Shortcode.setup do |config|
  config.template_path = "#{Devx::Engine.root}/app/views/devx/shortcode_templates"
  config.block_tags = [ ]
  config.self_closing_tags = [ :slideshow, :event_list_boxed, :media ]
end

Shortcode.register_presenter(Devx::SlideshowPresenter, Devx::EventListBoxedPresenter, Devx::MediaPresenter)