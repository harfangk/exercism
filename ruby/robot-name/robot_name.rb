require 'set'

module BookKeeping
  VERSION = 2
end

class Robot
  attr_accessor :name
  @@used_name_set = Set.new

  def initialize
    @name = create_name
    @@used_name_set.add(@name)
  end

  def reset
    @name = create_name   
  end

  private
  def create_name
    string_part = Array.new(2) {('A'..'Z').to_a.sample}.join
    number_part = rand(100..999).to_s
    name = string_part << number_part
    @@used_name_set.include?(name) ? create_name : name
  end
end

