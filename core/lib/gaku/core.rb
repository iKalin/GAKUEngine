require 'rails/all'
require 'rails/generators'
require 'paperclip'
require 'ransack'
require 'jquery-rails'
require 'devise'
require 'cancan'

module Gaku

  module Core
  end

  # Used to configure Gaku.
  #
  # Example:
  #
  #   Gaku.config do |config|
  #     config.site_name = "Gaku site"
  #   end

  def self.config(&block)
    yield(Gaku::Config)
  end
end

require 'gaku/core/delegate_belongs_to'
require 'gaku/core/version'
require 'gaku/core/engine'
require 'generators/gaku/dummy/dummy_generator'