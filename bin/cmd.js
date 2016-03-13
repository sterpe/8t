#!/usr/bin/env node

var args = require('minimist')(process.argv.slice(2))
var clear = require('cli-clear')
var eighty = require('../')

clear()
console.log(eighty)
