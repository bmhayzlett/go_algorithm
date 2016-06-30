require 'byebug'

class Game
  attr_accessor :board

  def initialize(size)
    @size = size
    @board = Array.new(size) { Array.new(size) {nil}}
  end

  def seed_board
    self[0,1] = 'b'
    self[0,2] = 'b'
    self[0,3] = 'b'
    self[1,0] = 'b'
    self[2,0] = 'b'
    self[3,0] = 'b'
    self[4,0] = 'b'
    self[1,1] = 'w'
    self[2,1] = 'w'
    self[3,1] = 'w'
    self[4,1] = 'w'
    self[1,2] = 'b'
    self[2,2] = 'w'
    self[3,2] = 'b'
    self[4,2] = 'b'
    self[1,3] = 'w'
    self[2,3] = 'w'
    self[3,3] = 'b'
    self[1,4] = 'b'
    self[2,4] = 'b'
  end

  def [](row, col)
    return "OOB" unless checkbounds(row,col)
    @board[row][col]
  end

  def []=(row, col, color)
    return "OOB" unless checkbounds(row,col)
    @board[row][col] = color
  end

  def death?(row,col)
    self_color = self[row,col]

    checked = Hash.new(false)
    pos_array = []
    pos_array.push([row,col])

    until pos_array.empty?
      tester = pos_array.shift
      return false unless self[tester[0],tester[1]]

      x,y = tester[0] + 1, tester[1]
      pos_array.push([x,y]) if add_pos?(x,y,self_color,checked)
      checked[[x,y]] = true
      x,y = tester[0], tester[1] + 1
      pos_array.push([x,y]) if add_pos?(x,y,self_color,checked)
      checked[[x,y]] = true
      x,y = tester[0]- 1, tester[1]
      pos_array.push([x,y]) if add_pos?(x,y,self_color,checked)
      checked[[x,y]] = true
      x,y = tester[0], tester[1] - 1
      pos_array.push([x,y]) if add_pos?(x,y,self_color,checked)
      checked[[x,y]] = true
    end

    return true

  end

  private

  def checkbounds(row,col)
    return false if row >= @size || col >= @size || row < 0 || col < 0
    true
  end

  def add_pos?(row,col,color,checked)
    if checkbounds(row,col) == false
      return false
    elsif self[row,col] == 'b' && color == 'w'
      return false
    elsif self[row,col] == 'w' && color == 'b'
      return false
    elsif checked[[row,col]] == true
      return false
    else
      return true
    end
  end

end
