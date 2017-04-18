class PostPublisher
  class PostNotFound
    def update(*)
      false
    end
  end

  attr_reader :post

  def initialize(title)
    @post = Post.find_by(title: title) || PostNotFound.new
  end

  def publish
    post.update(published: true)
  end
end
