require_relative 'board'

# The sudoku puzzles that your program will solve can be found
# in the sudoku_puzzles.txt file.
#
# Currently, Line 18 defines the variable board_string to equal
# the first puzzle (i.e., the first line in the .txt file).
# After your program can solve this first puzzle, edit
# the code below, so that the program tries to solve
# all of the puzzles.
#
# Remember, the file has newline characters at the end of each line,
# so we call String#chomp to remove them.

File.readlines('sudoku_puzzles.txt').each_with_index do |board_string, idx|
  board = Board.new(board_string)
  puts board.pretty
  if board.solve
    puts "Board #{idx} was solved!"
    puts board.pretty
    puts
  else
    puts "Board #{idx} wasn't solved :("
  end
end

