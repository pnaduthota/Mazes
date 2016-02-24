class Maze
  # define directions
  N, S, E, W = 1, 2, 4, 8
  # define change in directions
  DX = {E => 1, W => -1, N => 0, S => 0}
  DY = {E => 0, W => 0, N => 1, S => -1}
  # define opposite directions
  OPPOSITE = {E => W, W => E, S => N, N => S}

  # initialize maze
  def initialize()
    # get height and width of maze
    puts "Enter width of maze: "
    @width = $stdin.gets.to_i
    puts "Enter height of maze: "
    @height = $stdin.gets.to_i

    # use this data to create a grid
    @grid = Array.new(@height) { Array.new(@width, 0) }
    @solution_path = Array.new
    @trace = Array.new

    # set the initial point as 0 to signify that it is visited
    # create the maze
    carve_maze(0, 0, @grid)
  end

  # create the maze with the variables inputted
  def carve_maze(currentx, currenty, grid)
    # ensures that the directions are random and not biased
    directions = [N, S, E, W].sort_by{rand}

    directions.each do |direction|
      # define the new x and new y by the cnage that will occur if they do in
      # the direction indicated
      # for example, if going north, newx = currentx and newy = currenty + 1
      newx = currentx + DX[direction]
      newy = currenty + DY[direction]

      # if the new x is within the grid, and the new y is in the grid, and
      # the grid is unvisited, then we carve a path between the current coordinate
      # and the new coordinate.
      # the 'carve path' solution is explained in the readme file
      # then, we do carve_path on the new coordinates.
      if newy.between?(0, @grid.length - 1) && newy.between?(0, @grid[newy].length - 1) && @grid[newy][newx] == 0
        @grid[currenty][currentx] += direction
        @grid[newy][newx] += OPPOSITE[direction]
        carve_maze(newx, newy, @grid)
      end
    end
  end

  # method to display the maze
  def display()
    # print a top of the maze
    puts "_" + "_" * (@width * 2 - 1) + "_"

    # for each row...
    @height.times do |y|
      # print the left hand side
      print "|"

      # for each column in the row...
      @width.times do |x|
        # if the coordinate can go south, print " "
        # else, print a wall below ("_")
        if @grid[y][x] & S != 0
          print " "
        else
          print "_"
        end

        # if the coordinate can go east, and the [y][x+1] can go south,
        # print " ". Otherwise, print " ".
        # print '|' if the coordinate can't go east.
        if @grid[y][x] & E != 0
          print(((@grid[y][x] || @grid[y][x+1]) & S != 0) ? " " : "_")
        else
          print "|"
        end
      end
      # generate a new line
      puts
    end
  end

  # solve maze
  def solve(begx, begy, endx, endy)
    # if the coordinates are off the grid, return false
    if begx > @width-1 || begy > @height-1 || begx < 0 || begy < 0
      return false
    end

    # if the coordinate is the target coordinate, then end
    # the recursive tracing
    # return true
    if begx == endx && begy == endy
      return true
    end

    # if the coordinate is a wall or dead end, then return false
    if @grid[begy][begx] == 0
      return false
    end

    coor = "[#{begy}, #{begx}]"

    # if the coordinate has already been visited, stop recursion
    # otherwise, add to the solution path
    if @solution_path.include? coor
      return false
    else
      @solution_path.push(coor)
    end

    # try going north if you can
    # if you can, add to the trace array that keeps track of coordinates
    # that are part of the solution
    if solve(begx, begy + 1, endx, endy) == true
      @trace.push(coor)
      return true
    end

    # try going east if you can
    # if you can, add to the trace array that keeps track of coordinates
    # that are part of the solution
    if solve(begx + 1, begy, endx, endy) == true
      @trace.push(coor)
      return true
    end

    # try going west if you can
    # if you can, add to the trace array that keeps track of coordinates
    # that are part of the solution
    if solve(begx - 1, begy, endx, endy) == true
      @trace.push(coor)
      return true
    end

    # try going south if you can
    # if you can, add to the trace array that keeps track of coordinates
    # that are part of the solution
    if solve(begx, begy - 1, endx, endy) == true
      @trace.push(coor)
      return true
    end

    # delete the coordinate after recursion
    @solution_path.delete(coor)

    # return false if there is no solution
    return false
  end

  # print the solution path in reverse
  def trace()
    p @trace.reverse
  end

  # recreate the maze
  def redesign()
    @grid = Array.new(@height) { Array.new(@width, 0) }
    carve_maze(0, 0, @grid)
  end

  puts "Initialize a new test maze, 8x8."
  test = Maze.new
  puts "Display the test maze."
  test.display
  puts "Test to see if there is a solution from (0,0) to (3,5)"
  puts test.solve(0, 0, 3, 5)
  puts "Print the solution path. [] if no solution."
  test.trace
  puts "Redesign the maze. Reprint a new maze."
  test.redesign
  test.display
end
