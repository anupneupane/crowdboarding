class ActiveRecord::Base  
  def self.escape_sql(array)
    self.send(:sanitize_sql_array, array)
  end
end

class ActiveRecord::ConnectionAdapters::SQLiteAdapter
  def quoted_true
    '1'
  end 
  
  def quoted_false
    '0'
  end
end