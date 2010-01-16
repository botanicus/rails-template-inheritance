# encoding: utf-8

if RUBY_VERSION < "1.9.1"
  abort "Don't forget that Rango requires at least Ruby 1.9.1!"
end

require "tilt"
require "rango/mixins/render"
require "action_view/helpers"

# Rango setup
Tilt.register "erb", Tilt::ErubisTemplate # extension "erb" => erubis template
Rango.logger = Rails.logger

# Rango::Template has just getter, because then it holds just one object,
# so if you create a reference to, it will just work.
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
      render_for_text Rango::RenderMixin.render(template_path.template_path, self.scope, self.locals), status
    end

    def locals
      @locals ||= {request: request}
    end

    def scope
      self.dup.tap do |scope|
        scope.extend(self.class.master_helper_module)
        ActionView::Helpers.constants.grep(/Helper$/).each do |name|
          helper = ActionView::Helpers.const_get(name)
          scope.extend(helper)
          scope.instance_variable_set(:@controller, self)
        end
      end
    end
  end
end
