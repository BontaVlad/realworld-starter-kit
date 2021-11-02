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


var obj = User(id: 1, email: "email-value", username: "username-value")


func tName*(model: typedesc[Model]): string =
  when model.hasCustomPragma(tName):
    result = model.getCustomPragmaVal(tName)
  else:
    '"' & toLowerAscii($typedesc(model)) & '"'


echo User.tName
