require 'digest'
require 'json'

module BlockChain
  class Basic

    FIELDS_TO_HASH = [:index, :timestamp, :payload, :previous_hash]

    attr_reader :index, :timestamp, :payload, :previous_hash, :hash

    def initialize(previous, payload)
      @timestamp     = Time.now
      @payload       = payload
      @index         = previous.nil? ? 0 : previous.index+1
      @previous_hash = previous.nil? ? nil : previous.hash
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
