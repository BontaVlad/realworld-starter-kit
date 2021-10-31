import std/[macros, strutils]


template tName*(val: string) {.pragma.}

type
  Model* = ref object of RootObj
  User* = ref object of Model
    id*: int
    email*: string
    username*: string


proc newUser(id=1, email="foo-email", username="foo-username"): User =
  User(id: id, email: email, username: username)
# var obj = User(id: 1, email: "email-value", username: "username-value")

# for fld, val in obj[].fieldPairs:
#   print fld
#   print val
#
# for fld, val in User()[].fieldPairs:
#   print fld
#   print val
#
func name*(T: typedesc[Model]): string =
  when T.hasCustomPragma(tName):
    result = T.getCustomPragmaVal(tName)
  else:
    '"' & toLowerAscii($typedesc(T)) & '"'


# func cols*(T: typedesc[Model]): seq[string] =
# proc cols*(T: User) =
#   echo T.name
#   for fld, name in T[].fieldPairs:
#     echo name
    # result add $name

for fld, name in User()[].fieldPairs:
  echo fld
  # echo name

# obj.cols
