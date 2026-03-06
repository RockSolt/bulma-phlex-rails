# frozen_string_literal: true

SimpleCov.start do
  add_filter "/test/"
  add_filter "/version.rb"
  add_filter "/engine.rb"
  add_filter "/lib/bulma-phlex-rails.rb"
  add_filter "/lib/bulma_phlex/rails.rb"

  enable_coverage :branch

  track_files "#{__dir__}/lib/**/*.rb"
end
