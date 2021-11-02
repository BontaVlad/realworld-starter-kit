import std/[json]
import prologue

import ../core/[middleware]
import ../core/views


proc getArticlesView*(ctx: Context) {.async.} =
  let
    ctx = DbContext(ctx)

  let articles = @[
    %*{
      "slug": "string",
      "title": "string",
      "description": "string",
      "body": "string",
      "tagList": ["string", "string"],
      "createdAt": "2021-10-29T14:36:11.354Z",
      "updatedAt": "2021-10-29T14:36:11.354Z",
      "favorited": true,
      "favoritesCount": 0,
      "author": {
        "username": "string",
        "bio": "string",
        "image": "string",
        "following": true
      }
    }]
  jresp %*{"articles": articles, "articlesCount": 0}, Http200
