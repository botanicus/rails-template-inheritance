#!/usr/bin/env gem build
# encoding: utf-8

Gem::Specification.new do |s|
  s.name = "rails-template-inheritance"
  s.version = "0.0.1"
  s.authors = ["Jakub Šťastný aka Botanicus"]
  s.homepage = "http://github.com/botanicus/rails-template-inheritance"
  s.summary = "Template inheritance from Rango to Rails"
  s.description = "" # TODO: long description
  s.cert_chain = nil
  s.email = ["knava.bestvinensis", "gmail.com"].join("@")
  s.has_rdoc = true

  # files
  s.files = Dir.glob("{lib,spec}/**/*") + Dir["*"]
  s.require_paths = ["lib"]

  # Ruby version
  s.required_ruby_version = ::Gem::Requirement.new("~> 1.9")

  # dependencies
  s.add_dependency "tilt"
  s.add_dependency "rango"
end
