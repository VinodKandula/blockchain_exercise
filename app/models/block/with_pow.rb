require_relative './basic.rb'

class Block::WithPow < Block::Basic

  FIELDS_TO_HASH += [:nonce]
  attr_reader :nonce

  def initialize(previous, payload)
    @nonce = 0
    super(previous, payload)
    generate_pow
  end

  def valid?
    super && pow_achieved?
  end

  private

  def generate_pow
    while !pow_achieved?
      @nonce += 1
      @hash = to_hash
    end
  end

  def pow_achieved?
    hash[0..3] == '0000'
  end

end
