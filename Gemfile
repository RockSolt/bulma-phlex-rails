# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in bulma-phlex-rails.gemspec
gemspec

group :development, :test do
  gem "irb"
  gem "minitest", "~> 5.16"
  gem "minitest-difftastic"
  gem "rake", "~> 13.0"
  gem "rubocop", "~> 1.21"

  # point to main branch of bulma-phlex until it releases related changes in new version
  gem "bulma-phlex", github: "rocksolt/bulma-phlex", branch: "main"
end
