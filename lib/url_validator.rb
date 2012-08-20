require 'addressable/uri'


class UrlValidator < ActiveModel::EachValidator

  VALID_URL = URI::regexp(%w(http https))

  def validate_each(record, attribute, value)
    site = Addressable::URI.heuristic_parse(value, scheme: 'http').site
    record.errors.add(attribute, :invalid) if site !~ VALID_URL
  end

end

