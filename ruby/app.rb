require 'sinatra'
require 'opentelemetry/sdk'
require 'opentelemetry/exporter/otlp'
require 'opentelemetry/instrumentation/all'
require 'opentelemetry-logs-sdk'
require 'opentelemetry-instrumentation-logger'
require 'opentelemetry-exporter-otlp-logs'
require 'logger'

# Configure OpenTelemetry Traces
OpenTelemetry::SDK.configure do |c|
  c.use_all
end
at_exit do
  OpenTelemetry.logger_provider.shutdown
end

# Note: Ruby OTEL Logs SDK is experimental and unstable.
# it also does not works well with sinatra

set :bind, '0.0.0.0'
set :port, 8080

$logger = Logger.new(STDOUT)
# logging works here
$logger.info("$logger configured")
begin
  raise StandardError, 'Intentional error from startup'
rescue StandardError => e
  $logger.error(e)
end

get '/' do
  # this doesn't work - logs are printed to console, but not captured by Otel - looks like a bug in otel?
  $logger.info("Handling root endpoint")
  'Hello from Ruby Sinatra!'
end

get '/throw-error' do
  raise StandardError, 'Intentional error from Ruby Sinatra application'
end

error StandardError do
  # does not work with otel
  $logger.error(env['sinatra.error'])
  "Error: #{env['sinatra.error'].message}"
end
