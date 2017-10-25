require 'sinatra'
require 'colorize'
require_relative '../block_chain/basic.rb'

LEDGER = [ BlockChain::Basic.first ]

set :bind, '0.0.0.0'

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
