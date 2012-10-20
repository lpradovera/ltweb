class Runner
  @running = false
  def self.run(params)
    @running = true
    scenarios = {
      "1" => "load-test-1-simple.xml",
      "3" => "load-test-3-input.xml"
    }
    File.unlink(params[:log_path]) if File.exists?(params[:log_path])
    command = "cd #{params[:base_dir]}; sudo sipp -i 127.0.0.1 -sf #{scenarios[params[:scenario]]} "
    command += "-l #{params[:concurrent]} -m #{params[:total]} -r #{params[:rate]} "
    command += "-s #{params[:scenario]} -p 8832 127.0.0.1 -trace_stat -stf #{params[:log_path]} -fd 10 > /dev/null 2>&1"
    p command
    system command
    @running = false
  end

  def self.running?
    @running
  end
end
