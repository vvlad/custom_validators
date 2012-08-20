require 'spec_helper'
# require 'debugger'

# class Validatable
# end



def validatable_object(&block)
  klass= Class.new(Validatable)
  klass.class_eval(&block) if block_given?
  def klass.name
    "ValidatableObjectInstance"
  end
  klass
end

describe DateTimeValidator do

  subject { Validatable.new }

  describe "#validates_after" do
    subject do
      $BEFORE = Time.now
      validatable_object do
        attr_accessor :start_date
        validates :start_date, date_time: { after: $BEFORE }
      end.new
    end

    it "should not allow blank values" do
      subject.should_not be_valid
      subject.errors[:start_date].should include("can't be blank")
    end

    it "should not allow dates before $BEFORE date" do
      subject.start_date = $BEFORE - 200 
      subject.should_not be_valid
      subject.errors[:start_date].grep(/must be greater than/).should_not be_empty
    end

    it "should allow dates after $BEFORE date" do
      subject.start_date = $BEFORE + 1 
      subject.should be_valid
      subject.errors[:start_date].grep(/must be greater than/).should be_empty
    end


  end

  describe "#validates_before" do
    subject do
      $AFTER = Time.now
      validatable_object do
        attr_accessor :start_date
        validates :start_date, date_time: { before: $AFTER }
      end.new
    end

    it "should not allow blank values" do
      subject.should_not be_valid
      subject.errors[:start_date].should include("can't be blank")
    end

    it "should not allow dates before $BEFORE date" do
      subject.start_date = $BEFORE + 200 
      subject.should_not be_valid
      subject.errors[:start_date].grep(/must be less than/).should_not be_empty
    end

    it "should allow dates after $BEFORE date" do
      subject.start_date = $BEFORE - 200
      subject.should be_valid
      subject.errors[:start_date].grep(/must be less than/).should be_empty
    end


  end


  describe "#expected_value" do
    subject do
      DateTimeValidator.new
    end
  end

end
