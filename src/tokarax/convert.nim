## Internal module of tokarax

from std/xmltree import attrs, XmlNode, xnText, xnElement, xnCData, xnEntity,
                        xnComment, items, kind, text, tag, len
from std/strformat import `&`
from std/strutils import strip, replace, repeat
from std/strtabs import len, pairs

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

proc toKaraxTag(node: XmlNode): string =
  result = &"{getKaraxTagName node.tag}"
  if not node.attrs.isNil:
    result.add "("
    for key, val in node.attrs:
      result.add &"{key} = \"{val}\", "

    result = result[0..^3] & ")"
  if node.len > 0:
    result.add ":"

proc toKarax*(html: XmlNode): string =
  ## Convert parsed html to Karax node representation
  proc process(node: XmlNode; ident = 2): string =
    if node.tag != "document":
      result = toKaraxTag node
      result.add "\l"
    template add(t: string) =
      a.add t
    for n in node:
      var a = ""
      case n.kind:
      of xnText:
        let txt = n.text.strip
        if txt.replace("\t").len > 0:
          add &"text \"{txt}\""
      of xnComment:
        add &"#{n.text}"
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
"""
