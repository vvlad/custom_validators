class PhoneValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    if value.present?
      n_digits = value.scan(/[0-9]/).size
      valid_chars = (value =~ /^[+\/\-() 0-9x\.]+$/)
      length = options[:length]||5
      if !(n_digits > length && valid_chars)
        record.errors.add(attribute, :invalid)
      end
    end
  end

end