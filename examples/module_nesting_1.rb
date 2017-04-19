module Blog
  module Post
    class Base
    end
  end

  class Post::Draft < Base
  end

  class Post::InReview < Base
  end

  class Post::Published < Base
  end
end
