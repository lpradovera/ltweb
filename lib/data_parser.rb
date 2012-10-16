require 'csv'

class DataParser
  class << self
    def parse(path)
      elapsed = []
      total = []
      success = []
      failed = []
      CSV.foreach(path, :headers => true, :col_sep => ";") do |row|
        elapsed << row["ElapsedTime(C)"]
        total << row["TotalCallCreated"].to_i
        success << row["SuccessfulCall(C)"].to_i
        failed << row["FailedCall(C)"].to_i
      end
      [elapsed, total, success, failed]
    end
  end
end

