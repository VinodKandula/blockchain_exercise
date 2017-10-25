require 'sinatra'
require 'colorize'
require 'serfx'
require_relative '../block_chain/basic.rb'

LEDGER = [ BlockChain::Basic.first ]

set :bind, '0.0.0.0'

set :show_exceptions, :after_handler

before do
  content_type :json
end

def print_ledger
  puts LEDGER.to_s.green
end

get "/ledger" do
  print_ledger
  LEDGER.to_json
end

# @param from
# @param to
# @param amount
post "/transaction" do
  from, to = params.values_at('from', 'to').map(&:downcase)
  amount = params['amount'].to_i
  LEDGER << BlockChain::Basic.next(LEDGER[-1], { to: to, from: from, amount: amount })
  print_ledger
  LEDGER[-1].to_json
end

error Serfx::RPCError do
  { error: env['sinatra.error'].message }.to_json
end

get "/network/members" do
  members = []
  Serfx.connect do |conn|
    response = conn.members
    members = response.body['Members'].map{|m| m['Addr'].unpack('CCCC').join('.') }
  end
  members.to_json
end

# @param host
post "/network/join" do
  host = params.values_at('host')
  Serfx.connect do |conn|
    conn.join host
  end
end
