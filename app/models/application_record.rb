class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def integer_string?(str)
   Integer(str)
   true
  rescue ArgumentError
   false
  end
  
end
