# tokarax

Converts HTML to Karax representation

## Usage


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
  -i=, --input=   string  REQUIRED  set input
  -o=, --output=  string  REQUIRED  set output
  -j, --justBody  bool    true      Use this to parse all tags (not just `body`)
```

## TODO

- [ ] Add tests

## License

GPL-3
