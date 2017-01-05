require_relative 'cell'

# From Rails docs, to add Array#in_groups_of
class Array
  def in_groups_of(number, fill_with = nil)
    if number.to_i <= 0
      raise ArgumentError,
        "Group size must be a positive integer, was #{number.inspect}"
    end

    if fill_with == false
      collection = self
    else
      # size % number gives how many extra we have;
      # subtracting from number gives how many to add;
      # modulo number ensures we don't add group of just fill.
      padding = (number - size % number) % number
      collection = dup.concat(Array.new(padding, fill_with))
    end

    if block_given?
      collection.each_slice(number) { |slice| yield(slice) }
    else
      collection.each_slice(number).to_a
    end
  end
end

class Board
  attr_reader :cells

  def initialize(board_string)
    @cells = (0..80).map{ |index| Cell.new(index, board_string[index].to_i) }
  end

  def pretty(focus=[])
    colored_cells = cells.map{ |cell| cell.colored(focus) }
    colored_cells.in_groups_of(9, nil).map { |row| row.join('') }.join("\n")
  end

  def solve(cells_left_last_time=nil)
    return true if complete?
    easy_win_indices.each do |idx|
      cells[idx].value = options(cells[idx]).first
    end
    return false if cells_left_last_time == cells_left
    solve(cells_left)
  end

  def board_string
    cells.map(&:value).join('')
  end

  def easy_win_indices
    empty_cell_indices.select{ |idx| options(cells[idx]).size == 1 }
  end

  def empty_cell_indices
    cells.map.with_index{ |cell,idx| idx if cell.value == 0}.compact
  end

  def cells_left
    empty_cell_indices.length
  end

  def complete?
    cells_left == 0
  end

  private

    def row(focus)
      cells.select{ |cell| cell.solved? && cell.row == focus.row } - [self]
    end

    def column(focus)
      cells.select{ |cell| cell.solved? && cell.column == focus.column } - [self]
    end

    def box(focus)
      cells.select{ |cell| cell.solved? && cell.box == focus.box } - [self]
    end

    def options(focus)
      (1..9).to_a - (row(focus).map(&:value) + column(focus).map(&:value) + box(focus).map(&:value))
    end

end