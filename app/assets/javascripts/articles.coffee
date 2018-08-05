$(document).on 'page:change', =>
  root = '#article-container'
  return unless $(root).length
  new @ArticleController(root)
  new @CommentController(root)
