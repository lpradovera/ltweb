class Watcher
  @current = [[], [], [], []]
  @running = false
  def self.watch(path, num_of_calls, polling = 3)
    p "START WATCHING **************************************"
    @current = [[], [], [], []]
    @running = true
    while @running do
      sleep(5)
      p "RUNNING WATCHER"
      series = DataParser.parse(path) if File.exists?(path)
      @current = series
      break if (series[1].last && (series[1].last + series[2].last) == num_of_calls)
    end
    p "END WATCHING **************************************"
  end

  def self.series
    @current
  end

  def self.running
    @running
  end

  def self.running=(running)
    @running = running
  end
end
