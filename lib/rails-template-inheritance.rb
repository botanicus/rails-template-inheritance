# encoding: utf-8

if RUBY_VERSION < "1.9.1"
  abort "Don't forget that Rango requires at least Ruby 1.9.1!"
end

require "tilt"
require "rango/mixins/render"

# Rango setup
Tilt.register "erb", Tilt::ErubisTemplate # extension "erb" => erubis template
Rango.logger = Rails.logger

# Rango::Template has just getter, because then it holds just one object,
# so if you create a reference, it will just work.
# You can use Rango::Template.template.paths.clear.unshift(path)
module Rango
  class Template
    def self.template_paths=(paths)
      @@template_paths = paths
    end
  end
end

module ActionController
  class Base
    def render_for_file(template_path, status = nil, layout = nil, locals = {}) #:nodoc:
      Rango::Template.template_paths = @template.view_paths
      path = template_path.respond_to?(:path_without_format_and_extension) ? template_path.path_without_format_and_extension : template_path
      logger.info("Rendering #{path}" + (status ? " (#{status})" : '')) if logger
      render_for_text Rango::RenderMixin.render(template_path.template_path, self, locals), status
    end
  end
end
