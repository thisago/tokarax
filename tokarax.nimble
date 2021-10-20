# Package

version       = "0.2.2"
author        = "Thiago Ferreira"
description   = "Converts HTML to Karax representation"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.0.0"
requires "cligen"

bin = @["tokarax"]
binDir = "build"
installExt = @["nim"]

task build_release, "Builds the release version":
  exec "nimble -d:release build"
task build_danger, "Builds the danger version":
  exec "nimble -d:danger build"
task gen_docs, "Generates the documentation":
  exec "nim doc --project --out:docs src/tokarax.nim"
