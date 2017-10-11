# blockchain_exercise
Exercise in block chain understanding

Very simple implementation with proof of work.

    require_relative './block_chain/pow.rb'
    b0 = BlockChain::Pow.first('x')
    b1 = BlockChain::Pow.next(b0, 'yyy')

### Refs

* https://medium.com/crypto-currently/lets-build-the-tiniest-blockchain-e70965a248b
* https://hackernoon.com/learn-blockchains-by-building-one-117428612f46
* https://hackernoon.com/why-everyone-missed-the-most-important-invention-in-the-last-500-years-c90b0151c169
* https://www.igvita.com/2014/05/05/minimum-viable-block-chain/
* https://followmyvote.com/online-voting-technology/blockchain-technology/

* https://github.com/openblockchains/awesome-blockchains
* https://github.com/openblockchains/awesome-blockchains/tree/master/blockchain.rb

* https://ethereum.stackexchange.com/questions/2812/ethereum-and-rails-tutorials
* https://blog.gridplus.io/scaling-blockchains-with-apache-kafka-814c85781c6
* http://scottlobdell.me/2017/01/practical-implementation-event-sourcing-mysql/
