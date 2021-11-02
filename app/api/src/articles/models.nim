import std/[times]

import ../core/orm/model
import ../core/orm/pragmas
import ../users/models


type
  Tag* = ref object of Model
    id*: int
    title*: string

  ArticleTags* = ref object of Model
    id*: int
    article_id*: int
    tag_id*: int

  ArticleUserFavorited* = ref object of Model
    id*: int
    article_id*: int
    user_id*: int

  Article* = ref object of Model
    slug*: string
    title*: string
    description*: string
    body*: string
    tags*: seq[string]
    createdAt*: DateTime
    updatedAt*: DateTime
    author*: User


template createArticlesSchema*(db: typed) {.dirty.} =
  echo "Creating articles schemas"
  db.schema([
    table(Article.name, [
      Column().increments("id"),
      Column().string("slug").unique().index(),
      Column().string("title"),
      Column().string("description"),
      Column().string("body"),
      Column().datetime("createdAt"),
      Column().datetime("updatedAt"),
      Column().foreign("author_id")
        .reference("id")
        .on(User.name)    # this could prove problematic with circular references
        .onDelete(SET_NULL)
    ])
  ])
