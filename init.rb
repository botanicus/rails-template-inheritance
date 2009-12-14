# encoding: utf-8

if RUBY_VERSION < "1.9.1"
  abort "Don't forget that Rango requires at least Ruby 1.9.1!"
end

require_relative "lib/rails-template-inheritance"
