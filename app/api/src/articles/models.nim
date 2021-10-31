import std/[times]

import ../core/orm/model
import ../users/models


type
  Tag*: ref object of Model
    name*: string

  Article* = ref object of Model
    slug*: string
    title*: string
    description*: string
    body*: string
    tagList*: seq[Tag]
    createdAt*: DateTime
    updatedAt*: DateTime
    author*: User
