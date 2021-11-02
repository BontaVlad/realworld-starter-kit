import prologue
import allographer/connection
import allographer/schema_builder


import ../core/orm/model
import ../users/models as usrM
import ../articles/models as arM


let
  env = loadPrologueEnv(".env")
  dbUrl = env.getOrDefault("databaseUrl", "real.db")
  db = dbOpen(Sqlite3, dbUrl, shouldDisplayLog=true)

usrM.createUserSchema(db)
arM.createArticlesSchema(db)
