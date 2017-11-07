require_relative '../models/block/basic.rb'
require_relative '../models/block/chain.rb'
require 'yaml'

get "/ledger/" do
  content_type :yaml
  $LEDGER.to_yaml
end

get "/ledger/entry/last" do
  content_type :yaml
  $LEDGER.last_block.to_yaml
end

get "/ledger/entry/count" do
  { size: $LEDGER.size }.to_json
end

# @param from
# @param to
# @param amount
post "/transaction" do
  from, to = params.values_at('from', 'to').map(&:downcase)
  amount = params['amount'].to_i
  $LEDGER << { to: to, from: from, amount: amount }
  $LEDGER.last_block.to_json
end
