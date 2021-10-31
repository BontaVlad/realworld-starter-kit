import std/[macros, options, strutils]

import allographer/schema_builder


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


proc schema(T: typedesc[Model]) =
  # db.schema([
  #   table(t_user, [
  #     Column().increments("id"),
  #     Column().string("email"),
  #     Column().string("username"),
  #     Column().string("password"),
  #     Column().string("bio"),
  #     Column().string("image")
  #   ])
  # ])
  result = @[table(T.name, [])]
