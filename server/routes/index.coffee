module.exports = (router) ->
  router.get '/', (req, res) ->
    res.render 'index'

  router.post '/', (req, res) ->
    res.redirect "/block/#{req.body.id}"
