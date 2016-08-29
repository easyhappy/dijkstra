
require 'minitest/autorun'
require_relative '../dijkstra.rb'

class DijkstraTest < MiniTest::Test
  def matrix_of_columns
    [[1, 2, 7],
     [1, 3, 9],
     [1, 6, 14],
     [2, 3, 10],
     [2, 4, 15],
     [3, 4, 11],
     [3, 6, 2],
     [4, 5, 6],
     [5, 6, 9]
    ]
  end

  def string_matrix_of_columns
    [['A', 'B', 7],
     ['A', 'C', 9],
     ['A', 'F', 14],
     ['B', 'C', 10],
     ['B', 'D', 15],
     ['C', 'D', 11],
     ['C', 'F', 2],
     ['D', 'E', 6],
     ['E', 'F', 9]
    ]
  end

  def invalid_matrix_of_columns
    [[1, 2, 7],
     [1, 3, 9],
     [1, 6, 14],
     [2, 3, 10],
     [2, 4, 15],
     [3, 4, 11],
     [3, 6, 2],
     [4, 5, 6],
     [5, 6, -9]
    ]
  end

  def repeat_and_different_weight_matrix_of_columns
    [[1, 2, 7],
     [2, 1, 9],
     [1, 6, 14],
     [2, 3, 10],
     [2, 4, 15],
     [3, 4, 11],
     [3, 6, 2],
     [4, 5, 6],
     [5, 6, 10]
    ]
  end

  def wrong_columns_number_matrix_of_columns
    [[1, 2],
     [1, 6, 14],
     [2, 3, 10],
     [2, 4, 15],
     [3, 4, 11],
     [3, 6, 2],
     [4, 5, 6],
     [5, 6, 10]
    ]
  end

  def test_paths_is_excepted
    dijkstra = Dijkstra.new(matrix_of_columns, 1, 5, is_debug?)
    dijkstra.run
    assert_equal([1, 3, 6, 5], dijkstra.paths)
  end

  def test_paths_is_exepted_when_is_string_matrix
    dijkstra = Dijkstra.new(string_matrix_of_columns, 'A', 'E', is_debug?)
    dijkstra.run
    assert_equal(['A', 'C', 'F', 'E'], dijkstra.paths)
  end

  def test_error_when_start_column_is_isolated
    dijkstra = Dijkstra.new(matrix_of_columns, 10, 5, is_debug?)
    dijkstra.run
    assert_equal(1, dijkstra.errors.size)
  end

  def test_error_when_repeat_and_different_weight_matrix_of_columns
    dijkstra = Dijkstra.new(repeat_and_different_weight_matrix_of_columns, 1, 5, is_debug?)
    dijkstra.run
    assert_equal(1, dijkstra.errors.size)
  end

  def test_error_when_wrong_columns_number
    dijkstra = Dijkstra.new(wrong_columns_number_matrix_of_columns, 1, 5, is_debug?)
    dijkstra.run
    assert_equal(1, dijkstra.errors.size)
  end

    def test_error_when_end_column_is_isolated
    dijkstra = Dijkstra.new(matrix_of_columns, 1, 10, is_debug?)
    dijkstra.run
    assert_equal(1, dijkstra.errors.size)
  end

  def test_error_when_has_negative_weight
    dijkstra = Dijkstra.new(invalid_matrix_of_columns, 1, 5, is_debug?)
    dijkstra.run
    assert_equal(1, dijkstra.errors.size)
  end

  private

  def is_debug?
    ARGV.include?("debug")
  end
end