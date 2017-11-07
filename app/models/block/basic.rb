require 'digest'
require 'json'

module Block
  class Basic
    include Comparable

    FIELDS_TO_HASH = [:index, :timestamp, :payload, :previous_hash]

    attr_reader :index, :timestamp, :payload, :previous_hash, :hash

    def initialize(previous_block, payload)
      @timestamp     = Time.now.to_i
      @payload       = payload
      @index         = previous_block.nil? ? 0 : previous_block.index+1
      @previous_hash = previous_block.nil? ? nil : previous_block.hash
      @hash          = to_hash
    end

    def to_hash
      signature = self.class::FIELDS_TO_HASH.map{|f| send(f).to_s}.join
      Digest::SHA256.hexdigest signature
    end

    def first?
      previous_hash.nil?
    end

    def valid?
      hash == to_hash
    end

    def to_json(options=nil)
      {
        timestamp: timestamp,
        index: index,
        hash: hash,
        previous_hash: previous_hash,
        payload: payload
      }.to_json
    end

    def ==(other_block)
      self.to_json == other_block.to_json
    end

    def superceeded_by?(other_block)
      (other_block.index > self.index) ||
      (other_block.index == self.index && self.timestamp > other_block.timestamp)
    end

    # make the :new method private, so cannot create new instances of class BlockChain::Basic directly
    private_class_method :new

    def self.first(payload="First block")
      new(nil, payload)
    end

    def self.next(previous, payload='Subsequent block...')
      new(previous, payload)
    end

  end
end
