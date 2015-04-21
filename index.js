'use strict'

var readFileSync = require('fs').readFileSync
  , parser = require('./chatParser.js')

var parse = function parse (text) {
      return parser.parse(text.replace(/^\ufeff/g, ''))
    }
  , parseFile = function parseFile (file) {
      return parse(readFileSync(file, 'utf8'))
    }


module.exports = { parse: parse
                 , parseFile: parseFile
                 }
