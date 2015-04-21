'use strict'

var peg = require('pegjs')
  , fs = require('fs')
  , path = require('path')

var readFileSync = fs.readFileSync
  , parser = peg.buildParser(readFileSync(path.join(__dirname, '/chat.pegjs'), 'utf8'))
  , parse = function parse (text) {
      return parser.parse(text.replace(/^\ufeff/g, ''))
    }
  , parseFile = function parseFile (file) {
      return parse(readFileSync(file, 'utf8'))
    }


module.exports = { parse: parse
                 , parseFile: parseFile
                 }
