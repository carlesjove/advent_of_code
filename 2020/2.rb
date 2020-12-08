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

    assert_equal ["abcde", "ccccccccc"], validator.get_valid
    assert_equal ["cdefg"], validator.get_invalid
  end

  def test_detects_invalid
    list = [
      "4-5 x: fxdnq",
      "1-2 f: sfffffffffffffffff",
      "8-9 l: xnllznclz",
    ]

    validator = PasswordValidator.new(list)

    assert_includes validator.get_invalid, "fxdnq"
    assert_includes validator.get_invalid, "sfffffffffffffffff"
    assert_includes validator.get_invalid, "xnllznclz"
  end
end

class PasswordValidator
  def initialize(list)
    @list = list
  end

  def get_valid
    @list.each_with_object([]) do |item, result|
      rule, letter, password = item.split
      range = Range.new *rule.split("-").map(&:to_i)
      letter.gsub!(":", "")

      how_many = password.count(letter)

      if range.cover?(how_many)
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

puts "Result to 2 is:"
puts "There are #{validator.get_valid.size} valid passwords"
