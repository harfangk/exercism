module BookKeeping
  VERSION = 2
end

class Acronym
  def self.abbreviate(str)
    camel_case_regex = /([A-Z][a-z])+/
    space_hyphen = str.split(/[ -]/)
    camel_case = space_hyphen.map do |substring|
      if substring =~ camel_case_regex
        substring.scan(camel_case_regex) 
      else
        substring
      end
    end.flatten
    camel_case.reduce("") { |memo, substring| memo += substring[0] }.upcase
  end
end
