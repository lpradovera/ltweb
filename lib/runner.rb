class Runner
  @running = false
  def self.run(params)
    @running = true
    File.unlink(params[:log_path]) if File.exists?(params[:log_path])
    command = "cd #{params[:base_dir]}; sudo sipp -i 127.0.0.1 -sf load-test-1-simple.xml "
    command += "-l #{params[:concurrent]} -m #{params[:total]} -r #{params[:rate]} -s 1 -p 8832 127.0.0.1 -trace_stat -stf #{params[:log_path]} -fd 10 > /dev/null 2>&1"
    p command
    system command
    @running = false
  end

  def self.running?
    @running
  end
end
