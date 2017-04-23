module ApplicationHelper
  def self.exception(message)
    begin
      raise message
    rescue Exception => e
      puts "ERROR: #{e.message}"
    end
  end
end
