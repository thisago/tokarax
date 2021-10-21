## Main module of tokarax

import tokaraxpkg/convert
export convert

from std/os import fileExists, getCurrentDir, `/`
from std/strformat import fmt
from std/htmlparser import parseHtml
from std/strutils import indent, `%`, split, join, strip
from std/xmltree import findAll

const nimFileBase = """# Generated with https://github.com/karaxnim/karax
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

proc main(input: string; output = ""; justBody = true) =
  ## Converts HTML to Karax representation
  let inFile = getCurrentDir() / input
  if not fileExists inFile:
    quit fmt"Input file '{input}' not exists"
  let html = parseHtml inFile.readFile
  var el = html
  if justBody:
    el = html.findAll("body")[0]
  let karaxDsl = toKarax el
  if output.len > 0:
    var nimFile = genNimFile karaxDsl
    writeFile output, nimFile
  else:
    echo karaxDsl

when isMainModule:
  import pkg/cligen
  dispatch main, help = {
    "justBody": "Use this to parse all tags (not just `body`)",
    "output": "Set output; Leave it blank to print in stdout",
    "input": "Set input"
  }
