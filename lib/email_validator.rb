class EmailValidator < ActiveModel::EachValidator

  FORMAT = /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

  def validate_each(record, attribute, value)
    if value.present?
      record.errors.add(attribute, :invalid) unless value =~ FORMAT
    end
  end

end