import std/[macros]
# import std/typeinfo
import print



template tName*(val: string) {.pragma.}

type
  Model = ref object of RootObj

type
  User* {.tName: "user".} = ref object of Model
    id*: int
    email*: string
    username*: string


func table*(T: typedesc[Model]): string =
  '"' & $T & '"'


var obj = User(id: 1, email: "email-value", username: "username-value")

# for name, value in fields(obj):
#   echo name
#   echo value
  # print tp
# for fld, name in obj[].fieldPairs:
#   print fld
#   echo typeof(fld)
#   echo name
#   # print val
#
# echo obj.table

echo typeof(obj).table
when obj.hasCustomPragma(tName):
  echo "Has custom pragma"
  echo obj.getCustomPragmaVal(tName)
