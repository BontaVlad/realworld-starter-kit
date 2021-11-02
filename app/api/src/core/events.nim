import std/[logging]


proc setLoggingLevel*() =
  addHandler(newConsoleLogger())
  logging.setLogFilter(lvlInfo)
