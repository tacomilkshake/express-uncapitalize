
# dependencies
expect = require 'expect.js'
express = require 'express'
supertest = require 'supertest'
uncapitalize = require '..'

# config
HOST = 'localhost'
PORT = 3000

# variables
server = null

# tests
describe 'Express Uncapitalize', ->

  # setup server
  before (done) ->
    app = express()
    app.use uncapitalize()
    app.get '*', (req, res, next) ->
      res.send 'ok'
    server = app.listen 3000, ->
      done()

  # shutdown server
  after (done) ->
    server.close done
    server = null

  it 'should not redirect lowercase paths', (done) ->
    supertest(server).get('/hello').end (err, res) ->
      expect(res.status).to.equal 200
      expect(res.text).to.equal 'ok'
      done()

  it 'should redirect paths with uppercase letters', (done) ->
    supertest(server).get('/Hello').end (err, res) ->
      expect(res.status).to.equal 301
      expect(res.redirect).to.equal true
      expect(res.headers.location).to.equal '/hello'
      done()

  it 'should not lowercase the query string', (done) ->
    supertest(server).get('/Hello?Foo=Bar').end (err, res) ->
      expect(res.status).to.equal 301
      expect(res.redirect).to.equal true
      expect(res.headers.location).to.equal '/hello?Foo=Bar'
      done()
