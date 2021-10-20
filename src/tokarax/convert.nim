## Internal module of tokarax

from std/xmltree import attrs, XmlNode, xnText, xnElement, xnCData, xnEntity,
                        xnComment, items, kind, text, tag, len
from std/strformat import `&`
from std/strutils import strip, replace, repeat, split, multiReplace
from std/strtabs import len, pairs

using
  node: XmlNode

proc getKaraxTagName(htmlTag: string): string =
  case htmlTag:
  of "#text": "text"
  of "#int": "int"
  of "#bool": "bool"
  of "#vthunk": "vthunk"
  of "#dthunk": "dthunk"
  of "#component": "component"
  of "#verbatim": "verbatim"
  of "div": "tdiv"
  of "s": "strikethrough"
  of "var": "var"
  of "i": "italic"
  of "b": "bold"
  of "u": "underlined"
  of "object": "object"
  of "discard": "discard"
  of "set": "set"
  of "text": "stext"
  else: htmlTag

func getText(node): string =
  if node.kind in {xnText, xnComment, xnCData, xnEntity}:
    let txt = node.text.strip
    if txt.replace("\l", "").len > 0:
      result = txt

proc toKaraxTag(node): string =
  result = &"{getKaraxTagName node.tag}"
  var hasParams = false
  if not node.attrs.isNil:
    hasParams = true
    result.add "("
    for key, val in node.attrs:
      result.add &"{key} = \"{val}\", "

    result = result[0..^3] & ")"
  var hasChild = false
  for n in node:
    if n.kind != xnText:
      hasChild = true
    elif n.getText.len > 0:
      hasChild = true
    if hasChild:
      break
  if hasChild or node.getText.len > 0:
    result.add ":"
  elif not hasParams:
    result.add "()"

proc toKarax*(html: XmlNode): string =
  ## Convert parsed html to Karax node representation
  proc process(node; ident = 2): string =
    if node.tag != "document":
      result = toKaraxTag node
      result.add "\l"
    template add(t: string) =
      a.add t
    for n in node:
      var a = ""
      case n.kind:
      of xnText:
        let txt = n.getText
        if txt.len > 0:
          add &"text \"{txt}\""
      of xnComment:
        let txt = n.getText.multiReplace({
          "#[": "# [",
          "]#": "] #",
        })
        if txt.split("\l").len > 1:
          add &"#[ {txt} ]#"
        else:
          add &"# {txt}"
      of xnElement:
        add process(n, ident + 2)
      else:
        discard
      if a.len > 1:
        result.add repeat(" ", ident) & a & "\l"
    result = result[0..^2]
  result = process html

when isMainModule:
  import std/htmlparser
  echo toKarax parseHtml """
<h1 id="title">Hello world</h1>
<button class="btn btn-danger">Click me</button>
<!-- I am a comment -->
<!-- ]#
Multiline
comment
#[ -->
"""
