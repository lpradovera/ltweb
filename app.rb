require "rubygems"
require "sinatra"
require "json"
require "haml"
require "sinatra/json"

autoload = %w(lib)
autoload.each do |directory|
  Dir[File.dirname(__FILE__) + "/#{directory}/*.rb"].each { |file| require file }
end

AHN_PATH = "/Users/luca/projects/loadtestapp"

get "/" do
  Watcher.running = false
  haml :index
end

post "/run" do
  defaults = {
    bind_ip: "127.0.0.1",
    bind_port: 8832,
    concurrent: 4,
    total: 20,
    rate: 2,
    target_ip: "127.0.0.1",
    target_ext: "1",
    update_rate: 10
  }
  run_params = defaults
  path = File.join(AHN_PATH, "results", "simple_asterisk.csv")
  run_params[:base_dir] = File.join(AHN_PATH, "sipp")
  run_params[:log_path] = path

  Thread.new do
    Runner.run(run_params)
  end

  Thread.new do
    Watcher.watch(path, run_params[:total])
  end
  json({status: "ok"})
end

get "/series" do
  json Watcher.series 
end
