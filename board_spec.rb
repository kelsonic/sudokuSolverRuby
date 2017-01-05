require_relative '../board'

RSpec.describe Board do
  let(:board) { Board.new('1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--')}
  let(:hard_board) { Board.new('---6891--8------2915------84-3----5-2----5----9-24-8-1-847--91-5------6--6-41----')}
  subject { board }

  it { should respond_to(:cells, :solve) }

  it '#initialize with string should set board_string and cells array' do
    expect(board.board_string).to eq '105802000090076405200400819019007306762083090000061050007600030430020501600308900'
    expect(board.cells.length).to eq 81
    expect(board.cells[3].value).to eq 8
  end

  it '#empty_cell_indices works' do
    expect(board.empty_cell_indices).to match_array [1, 4, 6, 7, 8, 9, 11, 12, 16, 19, 20, 22, 23, 27, 30, 31, 34, 39, 42, 44, 45, 46, 47, 48, 51, 53, 54, 55, 58, 59, 60, 62, 65, 66, 68, 70, 73, 74, 76, 79, 80]
  end

  it '#easy_win_indices works' do
    expect(board.easy_win_indices).to match_array [12, 16, 19, 23, 39, 42, 44, 60, 65, 68, 74]
  end

  it '#solve works for a basic case' do
    expect(board.cells_left).to eq 41
    expect(board.solve).to eq true
    expect(board.board_string).to eq '145892673893176425276435819519247386762583194384961752957614238438729561621358947'
  end

  it '#solve gives up for a complex case' do
    expect(hard_board.cells_left).to eq 51
    expect(hard_board.solve).to eq false
  end

  it '#complete? works' do
    b = Board.new('145892673893176425276435819519247386762583194384961752957614238438729561621358947')
    expect(b.complete?).to be_truthy
  end
end
