#!/usr/bin/env node

'use strict'

var eighty = require('../')
var win = process.platform.indexOf('win') === 0
var stdout = []
var crlf = '\r\n'
var lf = '\n'
var i = 0
var lines

// https://github.com/stevenvachon/cli-clear

if (!win) {
  stdout.push('\x1B[2J')
} else {
  lines = process.stdout.getWindowSize()[1]
  for (; i < lines; i++) {
    stdout.push(crlf)
  }
}

stdout.push('\x1B[0f')
stdout.push(eighty)
stdout.push(win ? crlf : lf)

process.stdout.write(stdout.join(''))
