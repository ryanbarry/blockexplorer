# node api modules
fs = require 'fs'

# express modules
express = require 'express'
router = express.Router()
path = require 'path'
favicon = require 'serve-favicon'
logger = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'

app = express()

# view engine setup
app.set 'views', path.join(__dirname, '../client/views')
app.set 'view engine', 'jade'

app.use favicon(__dirname + '/../client/images/favicon.ico')
app.use logger('dev')
#app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: false)
app.use cookieParser()
#app.use express.static(path.join(__dirname, 'public'))

# register route handlers
routesDir = fs.readdirSync path.join(__dirname, 'routes')
for entry in routesDir
  addRoutes = require path.join(__dirname, 'routes', entry)
  addRoutes router

app.use '/', router

# catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error 'Not Found'
  err.status = 404
  next err

# error handlers

# development error handler
# will print stacktrace
if app.get('env') is 'development'
  app.use (err, req, res, next) ->
    res.status err.status || 500
    res.render 'error',
      message: err.message,
      error: err

# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->
  res.status err.status || 500
  res.render 'error',
    message: err.message,
    error: {}

module.exports = app
