require_relative '../cell'

RSpec.describe Cell do
  let(:cell) { Cell.new(14, '-')}
  subject { cell }

  it { should respond_to(:row, :column, :box, :value) }

  it '#initialize with location and value should set value, row and column' do
    expect(cell.value).to eq 0
    expect(cell.row).to eq 1
    expect(cell.column).to eq 5
  end

  it '#initialize sets box correctly' do
    expect(cell.box).to eq [1, 0]
    expect( Cell.new(2, 0).box).to eq [0, 0]
    expect( Cell.new(80, 8).box).to eq [2, 2]
    expect( Cell.new(40, 5).box).to eq [1, 1]
    expect( Cell.new(16, 2).box).to eq [2, 0]
    expect( Cell.new(73, 2).box).to eq [0, 2]
  end

  it '#location works for a basic case' do
    expect(cell.location).to eq 14
  end

  it '#solved? works' do
    expect(cell.solved?).to be false
    cell.value = 8
    expect(cell.solved?).to be true
  end

end
