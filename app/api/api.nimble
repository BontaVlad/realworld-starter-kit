# Package

version       = "0.1.0"
author        = "api"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"
bin           = @["api"]


# Dependencies

requires "nim >= 1.7.1"
requires "prologue"
requires "allographer"
requires "print"
requires "quickjwt"
requires "jsony"

task release, "Builds a release version":
  echo("\nRelease Build...\n")
  exec("nimble c -d:release src/api --outdir:./bin")

task debug, "Builds a debug version":
  echo("\nDebug Build\n")
  exec("nimble c --verbose -d:debug --lineDir:on --debuginfo --debugger:native src/api --outdir:./bin")

task migrate, "Builds a debug version":
  echo("\nCreating migrations, migrating\n")
  exec("nim c -r -d:reset src/core/migrate --outdir:./bin")

# pre runner for 'exec' to first carry out a 'debug' task build above
before exec:
  exec("nimble debug")

# runs the 'debug' version
task exec, "Builds and runs a debug version":
  echo("\nDebug Run\n")
  exec("./bin/api")
