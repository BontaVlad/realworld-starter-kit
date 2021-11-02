import std/[macros, options, strutils]

import allographer/schema_builder


import pragmas


type
  Model* = ref object of RootObj

func name*(model: typedesc[Model]): string =
  when model.hasCustomPragma(tName):
    result = model.getCustomPragmaVal(tName)
  else:
    toLowerAscii($typedesc(model))

func cols*(model: typedesc[Model]): seq[string] =
  for fld, val in model()[].fieldPairs:
    result.add fld
