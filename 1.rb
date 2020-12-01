require "pry"

class ExpenseProcessor
  def initialize(expenses, group:)
    @expenses = expenses
    @group = group
  end

  def find_group
    all_groups = @expenses
    (@group - 1).times do
      all_groups = all_groups.product(@expenses)
    end
    all_groups.map!(&:flatten)
    groups = all_groups.select{|a| a.inject(&:+) == 2020 }
    groups.first.sort
  end

  def result
    find_group.inject(&:*)
  end
end


require "minitest/autorun"

class TestExpensesProcessor < Minitest::Test
  def test_it_works_for_pairs
    expenses = [
      1721,
      979,
      366,
      299,
      675,
      1456,
    ]

    processor = ExpenseProcessor.new(expenses, group: 2)

    assert_equal [299, 1721], processor.find_group
    assert_equal 514579, processor.result
  end

  def test_it_works_for_triplets
    expenses = [
      1721,
      979,
      366,
      299,
      675,
      1456,
    ]

    processor = ExpenseProcessor.new(expenses, group: 3)

    assert_equal [366, 675, 979], processor.find_group
    assert_equal 241861950, processor.result
  end
end

expenses = [
  408,
  1614,
  1321,
  1028,
  1018,
  2008,
  1061,
  1433,
  1434,
  1383,
  1645,
  1841,
  1594,
  1218,
  1729,
  1908,
  1237,
  1152,
  1771,
  1837,
  1709,
  1449,
  1876,
  1763,
  1676,
  1491,
  1983,
  1743,
  1845,
  999,
  1478,
  1929,
  1819,
  1385,
  1308,
  1703,
  1246,
  1831,
  1964,
  1469,
  1977,
  1488,
  1698,
  1640,
  1513,
  1136,
  1794,
  1685,
  1802,
  1520,
  1807,
  1654,
  1547,
  1917,
  1792,
  1949,
  1268,
  1626,
  1493,
  1534,
  1700,
  1844,
  1146,
  1049,
  1811,
  1627,
  1630,
  1755,
  1887,
  1290,
  1446,
  1968,
  168,
  1749,
  1479,
  1651,
  1646,
  1839,
  14,
  1918,
  1568,
  1554,
  1926,
  1942,
  1862,
  1966,
  1536,
  1599,
  1439,
  1766,
  1643,
  1045,
  1537,
  1786,
  1596,
  1954,
  1390,
  1981,
  1362,
  1292,
  1573,
  1541,
  1515,
  1567,
  1860,
  1066,
  1879,
  1800,
  1309,
  1533,
  1812,
  1774,
  1119,
  1602,
  1677,
  482,
  1054,
  1424,
  1631,
  1829,
  1550,
  1636,
  1604,
  185,
  1642,
  1304,
  1843,
  1773,
  1667,
  1530,
  1047,
  1584,
  1958,
  1160,
  1570,
  1705,
  1582,
  1692,
  1886,
  1673,
  1842,
  1402,
  1517,
  1805,
  1386,
  1165,
  1867,
  1153,
  1467,
  1473,
  1803,
  1967,
  1485,
  1448,
  1922,
  1258,
  1590,
  1996,
  1208,
  1241,
  1412,
  1610,
  1219,
  523,
  1813,
  1123,
  1916,
  1861,
  1020,
  1783,
  1052,
  1140,
  1994,
  1761,
  747,
  1885,
  1675,
  1957,
  1476,
  1382,
  1878,
  1099,
  1882,
  855,
  1905,
  1037,
  1714,
  1988,
  1648,
  1135,
  1859,
  1798,
  1333,
  1158,
  1909,
  652,
  1934,
  1830,
  1442,
  1224,
]

puts "The result for 1.1 is:"
puts ExpenseProcessor.new(expenses, group: 2).result

puts "The result for 1.2 is:"
puts ExpenseProcessor.new(expenses, group: 3).result
