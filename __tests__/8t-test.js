/* global
  jest
  describe
  it
  expect
*/

jest.dontMock('../')

describe([
  '8t'
].join(' '), function () {
  it([
    'should span 80 columns'
  ].join(' '), function () {
    var _8t = require('../')
    expect(_8t.length).toBe(80)
  })
  it([
    'should properly demarcate the columns'
  ].join(' '), function () {
    var _8t = require('../')
    expect(_8t[6] + _8t[7]).toBe('+8')
    ;[
      16,
      24,
      32,
      40,
      48,
      56,
      64,
      72,
      80
    ].forEach(function (n, i) {
      expect(_8t[n - 3] + _8t[n - 2] + _8t[n - 1])
        .toBe('+' + n)
    })
  })
})
