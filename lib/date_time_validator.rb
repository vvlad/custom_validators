=begin
class Project
  validates :start_date, datetime: { after: lambda { Time.current }, before: :end_date }
  validates :end_date, datetime: { after: :end_date }
end
=end

class DateTimeValidator < ActiveModel::EachValidator


  def validate_each(record, attribute, value)
    validates_after(record,attribute,value) if options[:after]
    validates_before(record,attribute,value) if options[:before]
  end

  protected
  
  def expected_value(record,helper)
    case helper
    when Symbol then record.send(helper)
    when Proc then record.instance_veval(&helper)
    when Date, DateTime, Time then helper
    else
      raise ArgumentError, "unknown class `#{helper.class}' expected to be a Symbol, Proc, Date, DateTime, Time"
    end
  end
  
  def validates_after(record,attribute,value) 
    expected = expected_value(record, options[:after])
    record.errors.add(attribute, :blank) and return unless value    
    record.errors.add(attribute, :greater_than, count: expected) unless value > expected
  end

  def validates_before(record,attribute,value)
    expected = expected_value(record, options[:before])
    record.errors.add(attribute, :blank) and return unless value
    record.errors.add(attribute, :less_than, count: expected) unless value < expected
  end
  
end



