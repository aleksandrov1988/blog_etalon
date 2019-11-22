module LikesHelper
  def like_tag(post, user)
    like = post.likes.find_by(user_id: user&.id)
    if like
      link_to(like, method: :delete, class: 'text-danger') do
        concat content_tag(:i, nil, class: ['fa', 'fa-heart'])
        concat ' '
        concat post.likes.count
      end
    else
      link_to(likes_path(post_id: post.id), method: :post, class: 'text-danger') do
        concat content_tag(:i, nil, class: ['fa', 'fa-heart-o'])
        concat ' '
        concat post.likes.count
      end
    end
  end
end
