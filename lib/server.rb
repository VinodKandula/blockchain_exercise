require 'sinatra'
require 'colorize'
require 'yaml'
require 'faraday'
require 'active_support/time'

require_relative './helper.rb'

set :bind, '0.0.0.0'
$stdout.sync = true

set :show_exceptions, :after_handler

before do
  content_type :json
end

require_relative '../app/controller/network.rb'
require_relative '../app/controller/ledger.rb'

$LEDGER = Block::Chain.new(Block::Basic)

every(5.seconds) do
  Faraday.post("http://localhost:4567/gossip")
end

post '/gossip' do
  logger.info "Gossiping for better blocks"
  code, body = 200, 'Unknown'
  nodes = Network.sample
  if nodes.empty?
    logger.warn "#{Network::node_name} has no other nodes in network."
    code, body = 404, 'No other hosts in network'
  else
    Network.sample.each do |node|
      gossip_log_prefix = "#{Network::node_name} gossiping with #{node[:name]}/#{node[:ip]}"
      logger.info "#{gossip_log_prefix}"
      begin
        last_block_from_node = YAML.load(Faraday.get("http://#{node[:ip]}:4567/ledger/entry/last").body)
      rescue
        logger.error "#{gossip_log_prefix} - Error gossiping for last block #{e}"
        next
      end
      last_block = $LEDGER.last_block
      #next if last_block == last_block_from_node
      if last_block.superceeded_by?(last_block_from_node)
        begin
          ledger_from_node = YAML.load(Faraday.get("http://#{node[:ip]}:4567/ledger/").body)
          if ledger_from_node.valid?
            logger.info "#{gossip_log_prefix} - Result 'REPLACING LEDGER'"
            body = "Ledger replaced"
            $LEDGER = ledger_from_node
          else
            logger.error "#{gossip_log_prefix} - Ledger failed validation"
          end
        rescue => e
          logger.error "#{gossip_log_prefix} - Error gossiping for Ledger #{e}"
        end
      else
        logger.info "#{gossip_log_prefix} - Result 'IN SYNC'"
        body = "Ledger unchanged"
      end
    end
  end
  [code, body]
end
