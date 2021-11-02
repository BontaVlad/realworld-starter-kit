import allographer/schema_builder
import allographer/query_builder

import ../core/orm/model


type
  User* = ref object of Model
    id*: int
    email*: string
    username*: string
    password*: string
    bio*: string
    image*: string


template createUserSchema*(db: typed) {.dirty.} =
  echo "Generating user schema"
  db.schema([
    table(User.name, [
      Column().increments("id"),
      Column().string("email"),
      Column().string("username"),
      Column().string("password"),
      Column().string("bio"),
      Column().string("image")
    ])
  ])
