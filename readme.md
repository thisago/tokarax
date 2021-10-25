# tokarax

Converts HTML to Karax representation

## Usage

### Lib

```nim
import pkg/tokarax
echo toKarax parseHtml """
<h1 id="title">Hello world</h1>
<button class="btn btn-danger">Click me</button>
<!-- I am a comment -->
<!-- ]#
Multiline
comment
#[ -->
"""
```

### CLI

**Example**
```bash
$ tokarax -i index.html -o main.nim
```

**Help**
```bash
$ tokarax --help
Usage:
  main [required&optional-params]
Converts HTML to Karax representation
Options:
  -h, --help                        print this cligen-erated help
  --help-syntax                     advanced: prepend,plurals,..
  -i=, --input=   string  REQUIRED  Set input
  -o=, --output=  string  ""        Set output; Leave it blank to print in stdout
  -j, --justBody  bool    true      Use this to parse all tags (not just `body`)
```

## TODO

- [ ] Add tests
- [ ] Create an vscode extension with this

## License

GPL-3
