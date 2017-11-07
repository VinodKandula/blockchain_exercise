require_relative './basic.rb'

class Block::Chain

  def initialize(type = Block::Basic)
    @block_type = type
    @blocks = [ @block_type.first ]
  end

  def << (payload)
    @blocks << @block_type.next(last_block, payload)
  end

  def size
    @blocks.size
  end

  def last_block
    @blocks.last
  end

  def valid?
    return false unless @blocks.all?(&:valid?)
    return false unless @blocks.each_cons(2).all? { |a, b| a.hash == b.previous_hash }
    return false unless (0..@blocks.size-1).to_a == @blocks.map(&:index)
    true
  end

  def to_json(opts=nil)
    @blocks.to_json
  end

end
