module PostsHelper
  def show_post_body(post)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    markdown.render(post.body)
  end
end
