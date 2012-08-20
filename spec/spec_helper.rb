

$: << File.expand_path("../../lib", __FILE__)

require 'active_model'
require 'custom_validators'


class Validatable
  include ActiveModel::Validations
  attr_accessor :title  
end