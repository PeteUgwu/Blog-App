require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject do
    Comment.new(
      post: Post.new(
        author: User.new(
          name: 'PeeTee',
          photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
          bio: 'Student from Nigeria.',
          posts_counter: 0
        ),
        title: 'Hey',
        text: 'This is my first post',
        likes_counter: 0,
        comments_counter: 0
      ),
      author: User.new(name: 'Jay', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Student from South Africa.', posts_counter: 0), text: 'This is a new comment'
    )
  end

  before { subject.save }

  it 'update_comments_counter should return a right result when calling it with after_save' do
    expect(subject.post.comments_counter).to eq(1)
  end
end