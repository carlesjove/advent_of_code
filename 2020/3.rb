require "minitest/autorun"
require "pry"

class TestTreeCounter < Minitest::Test
  def test_with_example
    input = [
      "..##.......",
      "#...#...#..",
      ".#....#..#.",
      "..#.#...#.#",
      ".#...##..#.",
      "..#.##.....",
      ".#.#.#....#",
      ".#........#",
      "#.##...#...",
      "#...##....#",
      ".#..#...#.#",
    ]

    result = TreeCounter.new(input, slope: [3, 1]).result

    assert_equal 7, result
  end

  def test_with_multiple_added_slopes
    input = [
      "..##.......",
      "#...#...#..",
      ".#....#..#.",
      "..#.#...#.#",
      ".#...##..#.",
      "..#.##.....",
      ".#.#.#....#",
      ".#........#",
      "#.##...#...",
      "#...##....#",
      ".#..#...#.#",
    ]
    slopes = [
      [1, 1],
      [3, 1],
      [5, 1],
      [7, 1],
      [1, 2],
    ]

    results = []
    slopes.each do |slope|
      results << TreeCounter.new(input.dup, slope: slope).result
    end

    assert_equal [2, 7, 3, 4, 2], results
    assert_equal 336, results.inject(&:*)
  end
end

class TreeCounter
  def initialize(input, slope:)
    @input = input
    @right, @down = slope
  end

  def result
    @input.shift # don't care bout first row

    items = []
    @input.each_with_index do |row, index|
      items << extract_item(row, index)
    end

    items.count("#")
  end

  private

  def extract_item(row, index)
    item = row[@right * (index + 1)]

    until item
      item = extract_item(row << row, index)
    end

    item
  end
end

input = File.readlines("./data/3.txt", chomp: true)
result = TreeCounter.new(input.dup, slope: [3, 1]).result
# 252

puts "result is: #{result}"

#######

input = File.readlines("./data/3.txt", chomp: true)
slopes = [
  [1, 1],
  [3, 1],
  [5, 1],
  [7, 1],
  [1, 2],
]

results = []
slopes.each do |slope|
  results << TreeCounter.new(input.dup, slope: slope).result
end
# wrong
# 3458391552

puts "result is #{results.inject(&:*)}"
