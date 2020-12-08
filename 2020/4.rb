# require "minitest/autorun"
require "pry"

class PassportValidator
  def initialize(input, required_fields: [])
    @input = input
    @required_fields = required_fields
  end

  def result
    validations = {
      "byr": lambda { |val| (1920..2002).cover?(val.to_i) },
      "iyr": lambda { |val| (2010..2020).cover?(val.to_i) },
      "eyr": lambda { |val| (2020..2030).cover?(val.to_i) },
      "hgt": lambda { |val|
        # (Height) - a number followed by either cm or in:,
        # If cm, the number must be at least 150 and at most 193.
        # If in, the number must be at least 59 and at most 76.
        is_valid_height = {
          "cm": lambda { |h| (150..193).cover?(h.to_i) },
          "in": lambda { |h| (59..76).cover?(h.to_i) }
        }
        unit = val[-2..]
        height = val[..-3]

        %(cm in).include?(unit) && is_valid_height[unit.to_sym].call(height)
      },
      "hcl": lambda { |val|
        # (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
        val.match?(/^#([0-9]|[a-f]){6}$/)
      },
      "ecl": lambda { |val|
        %w(amb blu brn gry grn hzl oth).include?(val.downcase)
      },
      "pid": lambda { |val|
        # (Passport ID) - a nine-digit number, including leading zeroes.
        val.match?(/^[0-9]{9}$/)
      }
    }

    objs = @input.split("\n\n")
    valid = 0

    objs.each do |obj|
      obj.gsub!("\n", " ")
      fields = obj.split.map {|s| s.split(":") }.to_h
      fields.delete("cid")

      next unless (@required_fields - fields.keys).none?

      if fields.all? { |key, val| validations[key.to_sym].call(val) }
        valid += 1
      end
    end

    valid
  end
end

input = File.read('./data/4.txt')
required_fields = ["ecl", "pid", "byr", "iyr", "hgt", "hcl", "eyr"]
result = PassportValidator.new(input.dup, required_fields: required_fields).result

puts "result is: #{result}"
