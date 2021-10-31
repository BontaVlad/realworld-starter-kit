# stolen from https://github.com/moigagoo/norm/blob/develop/src/norm/private/dot.nim
import std/macros


macro dot*(obj: ref object, fld: string): untyped =
  ## Turn ``obj.dot("fld")`` into ``obj.fld``.

  newDotExpr(obj, newIdentNode(fld.strVal))
