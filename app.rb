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
log_path = File.join(AHN_PATH, "results", "output.csv")

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
    update_rate: 10,
    scenario: 1
  }
  run_params = defaults
  run_params[:base_dir] = File.join(AHN_PATH, "sipp")
  run_params[:log_path] = log_path
  run_params[:scenario] = params[:scenario]
  run_params[:concurrent] = params[:concurrent].to_i if params[:concurrent].to_i > 0
  run_params[:total] = params[:total].to_i if params[:total].to_i > 0
  run_params[:rate] = params[:rate].to_i if params[:rate].to_i > 0

  Thread.new do
    Runner.run(run_params)
  end

  json({status: "ok"})
end

get "/series" do
  data = DataParser.parse(log_path)
  data[:running] = Runner.running?
  json data
end
