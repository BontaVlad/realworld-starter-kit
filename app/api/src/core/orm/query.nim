import std/[asyncdispatch, options, sequtils]

import allographer/connection
import allographer/query_builder

import model


const default_by_col = "id"


proc findImpl[T, U](rdb: Rdb, value: U, by: string,
                    columns:seq[string]): Future[Option[T]] {.async.} =
  result = await(rdb.table(T.name)
                 .select(columns)
                 .find(value, by))
                 .orm(T)

proc find*[T, U](rdb: Rdb, value: U, by=default_by_col): Future[Option[T]] {.async.} =
  result = await findImpl[T](rdb, value, by, T.cols)

# proc find*[T, U](rdb: Rdb, model: T, value: U, by=default_by_col, columns:seq[string]): Future[Option[T]] {.async.} =
#   # TODO: check if columns are valid table columns
#   result = await findImpl(rdb, model, value, by, columns)

# proc find*[T, U](rdb: Rdb, model: T, value: U, by=default_by_col, exclude:seq[string]): Future[Option[T]] {.async.} =
#   var columns = model.cols
#   keepIf(columns, proc(x: string): bool = x notin exclude)
#   result = await findImpl(rdb, model, value, by, columns)
