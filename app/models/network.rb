require 'serfx'

class Network

  SAMPLE_SIZE = 2

  def self.stats
    stats = nil
    Serfx.connect do |conn|
      stats = conn.stats
    end
    stats.body
  end

  def self.members
    members = []
    Serfx.connect do |conn|
      response = conn.members
      members = response.body['Members'].map{|m| { ip: m['Addr'].unpack('CCCC').join('.'), name: m['Name'], status: m['Status'] }}
    end
    members
  end

  def self.node_name
    @@name ||= stats['agent']['name']
  end

  def self.join(host)
    Serfx.connect do |conn|
      conn.join host
    end
  end

  def self.sample(sample_size=SAMPLE_SIZE)
    members.reject{|m| m[:name]==self.node_name}.sample(sample_size)
  end

end
