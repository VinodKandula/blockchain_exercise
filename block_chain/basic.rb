require 'digest'

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

    # make the :new method private, so cannot create new instances of class BlockChain::Basic directly
    private_class_method :new

    def self.first(data="First block")
      new(nil, data)
    end

    def self.next(previous, data='Subsequent block...')
      new(previous, data)
    end

  end
end
