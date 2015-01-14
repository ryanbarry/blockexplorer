module.exports = (router) ->
  Bitcoin = require 'bitcoin'
  btc = new Bitcoin.Client
    host: '127.0.0.1'
    port: 8332
    user: 'Ulysseys'
    pass: 'Odyssey'
    timeout: 30000

  router.get '/block/:id', (req, res) ->
    hash = req.params.id
    btc.getBlock hash, (err, block, resHeaders) ->
      console.log "resHeaders: ", resHeaders
      console.log "err: ", err
      res.render 'block',
        error: err
        block: block
        hash: hash
