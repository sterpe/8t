'use strict'

var e = 'Tab-size too small'

function writeTicks (tab, columns) {
  var j = Math.floor(columns / tab)
  var i = 1
  var s = ''
  var col
  var spaces

  j += 1
  for (; i < j; ++i) {
    col = i * tab
    spaces = tab - 1 - col.toString().length
    if (spaces < 0) {
      throw new Error(e)
    }
    while (spaces--) {
      s += ' '
    }
    s += '+'
    s += col.toString()
  }
  return s
}

module.exports = writeTicks(8, 80)
