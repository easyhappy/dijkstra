require './dijkstra'
# [a, b, number] 每行元素 表示 a 和 b 的 边权重是 number
matrix_of_columns = [[1, 2, 7],
                     [1, 3, 9],
                     [1, 6, 14],
                     [2, 3, 10],
                     [2, 4, 15],
                     [3, 4, 11],
                     [3, 6, 2],
                     [4, 5, 6],
                     [5, 6, 9]
                   ]
# 参数含义: 元素矩阵、开始点、结束点、是否debug
dijkstra = Dijkstra.new(matrix_of_columns, 1, 5, true)
dijkstra.run
