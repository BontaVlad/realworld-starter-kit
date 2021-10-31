import ../core/orm/model


type
  User* = ref object of Model
    id*: int
    email*: string
    username*: string
    password*: string
    bio*: string
    image*: string


proc createUserTables*() =
  discard
  # let
  #   env = loadPrologueEnv(".env")
  #   dbUrl = env.getOrDefault("databaseUrl", "real.db")
  #   db = dbOpen(Sqlite3, dbUrl, shouldDisplayLog=true)

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
