import std/[asyncdispatch, options, sequtils, json]

import allographer/connection
import allographer/query_builder

import model


const default_by_col = "id"


proc findImpl[T, U](rdb: Rdb, model: typedesc[T], value: U, by: string,
                    columns:seq[string]): Future[Option[JsonNode]] {.async.} =
  result = await rdb.table(model.name)
                 .select(columns)
                 .find(value, by)


proc findImplOrm[T, U](rdb: Rdb, model: typedesc[T], value: U, by: string,
                    columns:seq[string]): Future[Option[T]] {.async.} =
  result = await(rdb.table(model.name)
                 .select(columns)
                 .find(value, by))
                 .orm(model)


proc find*[T, U](rdb: Rdb, model: typedesc[T], value: U, by=default_by_col): Future[Option[T]] {.async.} =
  result = await findImplOrm(rdb, model, value, by, model.cols)


proc find*[T, U](rdb: Rdb, model: typedesc[T], value: U, by=default_by_col, columns:seq[string]): Future[Option[JsonNode]] {.async.} =
  # TODO: check if columns are valid table columns
  result = await findImpl(rdb, model, value, by, columns)


proc find*[T, U](rdb: Rdb, model: typedesc[T], value: U, by=default_by_col, exclude:seq[string]): Future[Option[JsonNode]] {.async.} =
  var columns = model.cols
  keepIf(columns, proc(x: string): bool = x notin exclude)
  result = await findImpl(rdb, model, value, by, columns)
