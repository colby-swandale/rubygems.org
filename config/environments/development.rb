require_relative "../../lib/middleware/hostess"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :mem_cache_store,
                         { compress: true, compression_min_size: 524_288 }
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  config.action_mailer.default_url_options = { host: Gemcutter::HOST,
                                               protocol: Gemcutter::PROTOCOL }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  # config.action_view.raise_on_missing_translations = true

  config.middleware.use Hostess

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Rubygems.org checks for the presence of an env variable called PROFILE that
  # switches several settings to a more "production-like" value for profiling
  # and benchmarking the application locally. All changes you make to the app
  # will require restart.
  if ENV['PROFILE']
    config.cache_classes = true
    config.eager_load = true

    config.logger = ActiveSupport::Logger.new(STDOUT)
    config.log_level = :info

    config.public_file_server.enabled = true
    config.public_file_server.headers = {
      'Cache-Control' => 'max-age=315360000, public',
      'Expires' => 'Thu, 31 Dec 2037 23:55:55 GMT'
    }
    config.assets.js_compressor = :uglifier
    config.assets.css_compressor = :sass
    config.assets.compile = false
    config.assets.digest = true
    config.assets.debug = false

    config.active_record.migration_error = false
    config.active_record.verbose_query_logs = false
    config.action_view.cache_template_loading = true
  end
end
