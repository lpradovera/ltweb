class Watcher
  @current = [[], [], []]
  @running = false
  def self.watch(path, num_of_calls, polling = 3)
    @current = DataParser.parse(path) if File.exists?(path)
    @running = true
    while @running do
      sleep(polling)
      p "RUNNING WATCHER"
      data = DataParser.parse(path) if File.exists?(path)
      p data
      if (data[:series][1].last && (data[:series][2].last + data[:series][3].last) == num_of_calls)
        data[:running] = false
        @running = false
        break
      else
        data[:running] = true
      end
      @current = data
    end
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
