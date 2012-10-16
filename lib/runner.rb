class Runner
  def self.run(params)
    File.unlink(params[:log_path])
    command = "cd #{params[:base_dir]}; sudo sipp -i 127.0.0.1 -sf load-test-1-simple.xml -l 4 -m 20 -r 2 -s 1 -p 8832 127.0.0.1 -trace_stat -stf #{params[:log_path]} -fd 10"
    p "BEGAN RUNNING SIPP WITH COMMAND"
    p command
    exec command
  end
end
