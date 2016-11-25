require 'bundler/setup'
Bundler.require(:default)

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.dirname(__FILE__ ) + '/models/')
$LOAD_PATH.unshift(File.dirname(__FILE__ ) + '/lib/')
$LOAD_PATH.unshift(File.dirname(__FILE__) + '/config/initializers')

SCRIPT_ROOT = File.dirname(__FILE__)

[
  './models/*.rb',
  './lib/*.rb',
  './config/initializers/*.rb',
].each do |dir|
  Dir.glob(dir).each do |file|
    require file
  end
end
