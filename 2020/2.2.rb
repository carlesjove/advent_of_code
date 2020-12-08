require "pry"
require "minitest/autorun"

class TestPasswordValidator < Minitest::Test
  def test_it_works_with_example
    list = [
      "1-3 a: abcde",
      "1-3 b: cdefg",
      "2-9 c: ccccccccc",
    ]

    validator = PasswordValidator.new(list)

    assert_equal ["abcde"], validator.get_valid
    assert_equal ["cdefg", "ccccccccc"], validator.get_invalid
  end
end

class PasswordValidator
  def initialize(list)
    @list = list
  end

  def get_valid
    @list.each_with_object([]) do |item, result|
      rule, letter, password = item.split
      positions = rule.split("-").map(&:to_i).map{ |i| i - 1 }
      letter.gsub!(":", "")

      res = positions.map{|i| password[i] }

      if res.any?(letter) && !res.all?(letter)
        result << password
      end
    end
  end

  def get_invalid
    passwords = @list.flat_map { |item| item.split.last }
    passwords - get_valid
  end
end

filepath = "./data/2.txt"
list = File.readlines(filepath, chomp: true)
validator = PasswordValidator.new(list)

puts "Result to 2.2 is:"
puts "There are #{validator.get_valid.size} valid passwords"
