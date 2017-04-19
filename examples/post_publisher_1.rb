class PostPublisher
  attr_reader :post

  def initialize(title)
    @post = Post.find_by(title: title)
  end

  def publish
    post.update(published: true)
  end
end
