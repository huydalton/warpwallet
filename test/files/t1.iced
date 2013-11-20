
{scrypt,WordArray} = require 'triplesec'
{generate} = require 'keybase-bitcoin'
params = require '../../src/json/params.json'
spec = require '../spec.json'
{run} = require '../../src/iced/top.iced'

run1 = (T, i, vec, cb) ->
  await run {
    passphrase : vec.passphrase
    salt : ''
    params
  }, defer ret

  if ret.public == '1FpxSs3tsvV8knTgRv2885bE1GyPq1QrvH'
    T.waypoint ret.private
    return
  cb()

exports.test_spec = (T, cb) ->
  for v,i in spec.vectors
    await run1 T, i, v, defer()
    T.waypoint "#{i}: #{v.passphrase}"
    await setTimeout defer(), 10
  cb()
