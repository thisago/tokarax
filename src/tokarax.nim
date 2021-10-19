## Main module of tokarax

import tokarax/convert
export convert

from std/os import fileExists, getCurrentDir, `/`
from std/strformat import fmt
from std/htmlparser import parseHtml
from std/strutils import indent, `%`, split, join, strip
from std/xmltree import findAll

const nimFileBase = """# Generated by `tokarax` tool
include pkg/karax/prelude

proc createDom(): VNode =
  result = buildHtml($1):
$2

setRenderer createDom"""
proc genNimFile(code: string): string =
  var parts = code.split "\l"
  result = nimFileBase % [
    parts[0][0..^2].strip,
    parts[1..^1].join("\l").indent 2
  ]

proc main(input, output: string; justBody = true) =
  ## Converts HTML to Karax representation
  let inFile = getCurrentDir() / input
  if not fileExists inFile:
    quit fmt"Input file '{input}' not exists"
  let html = parseHtml inFile.readFile
  var el = html
  if justBody:
    el = html.findAll("body")[0]
  var nimFile = genNimFile toKarax el
  writeFile output, nimFile

when isMainModule:
  import pkg/cligen
  dispatch main, help = {
    "justBody": "Use this to parse all tags (not just `body`)"
  }
