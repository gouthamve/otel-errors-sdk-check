require 'sinatra'
require 'opentelemetry/sdk'
require 'opentelemetry/exporter/otlp'
require 'opentelemetry/instrumentation/all'

# Configure OpenTelemetry Traces
OpenTelemetry::SDK.configure do |c|
  c.use_all
end

# Note: Ruby OTEL Logs SDK is experimental and unstable.
# Logs are written to stdout and can be collected via container logging.
# Traces and exception capture work via auto-instrumentation.

set :bind, '0.0.0.0'
set :port, 8080

get '/' do
  puts "[INFO] Received request to root endpoint"
  'Hello from Ruby Sinatra!'
end

get '/throw-error' do
  puts "[ERROR] About to throw an intentional error"
  raise StandardError, 'Intentional error from Ruby Sinatra application'
end

error StandardError do
  puts "[ERROR] Unhandled error: #{env['sinatra.error'].message}"
  "Error: #{env['sinatra.error'].message}"
end
