import std/[json, asyncdispatch, options, sequtils]

import prologue
import allographer/connection
import allographer/query_builder
import allographer/schema_builder


type
  User* = ref object
    id*: int
    email*: string
    username*: string
    password*: string
    bio*: string
    image*: string

const t_user* = "user"


proc createUserTables*() =
  let
    env = loadPrologueEnv(".env")
    dbUrl = env.getOrDefault("databaseUrl", "real.db")
    db = dbOpen(Sqlite3, dbUrl, shouldDisplayLog=true)

  db.schema([
    table(t_user, [
      Column().increments("id"),
      Column().string("email"),
      Column().string("username"),
      Column().string("password"),
      Column().string("bio"),
      Column().string("image")
    ])
  ])


proc getUser*[T](rdb: Rdb, value: T, by="id",
                 columns= @["id", "email", "username", "password", "bio", "image"],
                 exclude:seq[string]= @[]): Future[Option[JsonNode]] {.async.} =
  var col = columns
  keepIf(col, proc(x: string): bool = x notin exclude)
  result = await rdb.table(t_user)
    .select(col)
    .find(value, by)


proc getUserObj*[T](rdb: Rdb, value: T, by="id", model=User): Future[Option[User]] {.async.} =
  result = await(rdb.table(t_user)
                 .select()
                 .find(value, by))
                 .orm(User)
