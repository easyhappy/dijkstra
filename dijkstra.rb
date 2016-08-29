require 'set'

class Dijkstra
  attr_accessor :paths, :errors

  def initialize(matrix_of_columns, start_column, end_column, is_debug=false)
    @matrix_of_columns = matrix_of_columns
    @start_column = start_column
    @end_column = end_column
    @is_debug = is_debug

    self.paths = []
    self.errors = []

    @all_columns = Set.new

    @distance = {}
    @previous = {}
    @adjacency_dict = {}
    
    init_columns_and_adjacency_dict_from_matrix
    init_distance_and_previous_from_columns
  end

  def run
    validate_inputs
    unless self.errors.empty?
      if @is_debug
        puts "有以下错误信息, 请检查正确后 在重新执行: "
        puts self.errors
      end
      return
    end

    @distance[@start_column] = 0

    while @all_columns
      min_column = get_minimum_distance_column_from_remain_columns
      break if min_column == -1

      @adjacency_dict[min_column].each do |goto_item|
        if @distance[min_column] + goto_item[1] < @distance[goto_item[0]]
          @distance[goto_item[0]] = @distance[min_column] + goto_item[1]
          @previous[goto_item[0]] = min_column
        end
      end
    end
    generate_road_path
  end

  def generate_road_path
    current_column = @end_column
    while true
      self.paths.unshift current_column
     
      break if current_column == @start_column
      current_column = @previous[current_column]
    end

    if @is_debug
      puts "路径为: #{self.paths.map(&:to_s).join('->')}"
    end
  end

  private

  def validate_inputs
    unless @all_columns.include?(@start_column)
      self.errors << "开始点是一个孤立点"
    end

    unless @all_columns.include?(@end_column)
      self.errors << "结束点是一个孤立点"
    end
  end

  def get_minimum_distance_column_from_remain_columns
    min_column = -1
    @all_columns.each do |column|
      if min_column == -1
        min_column = column
        next
      end

      if column < @distance[min_column]
        min_column = column
      end
    end
    @all_columns.delete min_column
    return min_column
  end
   
  def init_columns_and_adjacency_dict_from_matrix
    for item in @matrix_of_columns
      @all_columns << item[0]
      @all_columns << item[1]

      if item[2] < 0
        self.errors << "#{item[0]} - #{item[1]} 是负权值, 请检查输入值!"
      end

      @adjacency_dict[item[0]] ||= []
      @adjacency_dict[item[0]] << [item[1], item[2]]

      @adjacency_dict[item[1]] ||= []
      @adjacency_dict[item[1]] << [item[0], item[2]]
    end
  end

  def init_distance_and_previous_from_columns
    @all_columns.each do |column|
      @distance[column] = Float::INFINITY
    end
  end
end