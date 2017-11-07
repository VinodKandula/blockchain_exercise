require_relative '../models/network.rb'

error Serfx::RPCError do
  { error: env['sinatra.error'].message }.to_json
end

get "/network/members" do
  Network.members.to_json
end

get "/network/stats" do
  Network.stats.to_json
end

# @param host
post "/network/join" do
  host = params.values_at('host')
  Network.join host
end
