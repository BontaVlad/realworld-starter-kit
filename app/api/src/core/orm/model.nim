# stolen from https://github.com/moigagoo/norm/blob/develop/src/norm/model.nim
import std/[macros, options, strutils]


import pragmas


type
  Model* = ref object of RootObj

func name*(T: typedesc[Model]): string =
  when T.hasCustomPragma(tName):
    result = T.getCustomPragmaVal(tName)
  else:
    '"' & toLowerAscii($typedesc(T)) & '"'

func cols*(T: typedesc[Model]): seq[string] =
  for fld, val in T()[].fieldPairs:
    result.add fld
