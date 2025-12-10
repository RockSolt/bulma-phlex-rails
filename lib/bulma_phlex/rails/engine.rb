# frozen_string_literal: true

module BulmaPhlex
  module Rails
    # Rails Engine for BulmaPhlex
    class Engine < ::Rails::Engine
      initializer "bulma_phlex.rails.importmap", before: "importmap" do |app|
        app.config.importmap.paths << Engine.root.join("config/importmap.rb")
      end

      initializer "bulma_phlex.rails.assets" do |app|
        app.config.assets.paths << root.join("app/javascript")
      end
    end
  end
end
