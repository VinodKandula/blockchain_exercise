# blockchain_exercise
Exercise in block chain understanding

At it's core is a very simple implementation with proof of work.

    $ irb
    require_relative './models/block/with_pow.rb'
    b0 = Block::WithPow.first('x')
    b1 = Block::WithPow.next(b0, 'yyy')

To run the block chain as a cluster of nodes both `docker` and `docker-compose` must be installed on the host system.

To start the cluster run

    docker-compose up

This will start 2 block chainn nodes.  Both are identical, one is bound to your host systems network for easy interaction, the other an example node simmulating a node on another network and inaccessible.  To scale the block chain nodes beyond 2 run the following;

   docker-compose scale blockchain=2

Once you have the number of block chain nodes desired they must be made aware of each other and clustered.  To network the nodes together allowing them to gossip effectively run the following helper script;

    ./bootstrap_network.sh

This will locate the ip's of all the docker containers and then make a htto call to the block chain node exposed to the host to register each ip.  From there the gossip protocal makes sure that every node in the network is aware of every other node.

To add a transaction to the chain;

    curl -d "to=Jane&from=Fred&amount=2" localhost:80/transaction

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
* https://bigishdata.com/2017/11/02/build-your-own-blockchain-part-3-writing-nodes-that-mine/
* https://github.com/Haseeb-Qureshi/lets-build-a-blockchain

* https://blog.codeship.com/build-minimal-docker-container-ruby-apps/
*

* https://ethereum.stackexchange.com/questions/2812/ethereum-and-rails-tutorials
* https://blog.gridplus.io/scaling-blockchains-with-apache-kafka-814c85781c6
* http://scottlobdell.me/2017/01/practical-implementation-event-sourcing-mysql/
