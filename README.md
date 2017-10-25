# blockchain_exercise
Exercise in block chain understanding

Very simple implementation with proof of work.

    require_relative './block_chain/pow.rb'
    b0 = BlockChain::Pow.first('x')
    b1 = BlockChain::Pow.next(b0, 'yyy')

### Exercise direction

* Basic block chain implementation
** Proof-of-work implementation
** Proof-of-stake implementation
* Distribute ledger
** Service discovery
** Concensus
** Chain validation
** Chain synchronization
* Block chain use-case implementation - Voting
** Voter authentication
** Tally functionality

### Interactions

To review a ledger

    curl localhost:4567/ledger

To post a transaction

    curl -d "from=foo&to=bar&amount=2" localhost:4567/transaction

### Hashicorp Serf

* https://releases.hashicorp.com/serf/0.8.1/serf_0.8.1_linux_amd64.zip

* https://www.ctl.io/developers/blog/post/decentralizing-docker-how-to-use-serf-with-docker/
* https://www.ctl.io/developers/blog/post/auto-loadbalancing-with-fig-haproxy-and-serf/

* https://github.com/ranjib/serfx
* http://tldp.org/LDP/abs/html/internalvariables.html

### Refs

* https://www.igvita.com/2014/05/05/minimum-viable-block-chain/
* https://www.pluralsight.com/guides/software-engineering-best-practices/blockchain-architecture
* https://www.pluralsight.com/guides/software-engineering-best-practices/the-cryptography-of-bitcoin
* https://hackernoon.com/why-everyone-missed-the-most-important-invention-in-the-last-500-years-c90b0151c169
* https://medium.com/crypto-currently/lets-build-the-tiniest-blockchain-e70965a248b
* https://hackernoon.com/learn-blockchains-by-building-one-117428612f46
* https://followmyvote.com/online-voting-technology/blockchain-technology/

* https://github.com/openblockchains/awesome-blockchains
* https://github.com/openblockchains/awesome-blockchains/tree/master/blockchain.rb
* https://github.com/Haseeb-Qureshi/lets-build-a-blockchain

* https://blog.codeship.com/build-minimal-docker-container-ruby-apps/
*

* https://ethereum.stackexchange.com/questions/2812/ethereum-and-rails-tutorials
* https://blog.gridplus.io/scaling-blockchains-with-apache-kafka-814c85781c6
* http://scottlobdell.me/2017/01/practical-implementation-event-sourcing-mysql/
