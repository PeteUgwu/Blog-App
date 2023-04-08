require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Dammy', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Worker at BiteMore.', posts_counter: 0) }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'post counter should be equal or great than 0' do
    subject.posts_counter = -10
    expect(subject).to_not be_valid
  end

  it 'Subject should be valid' do
    expect(subject).to be_valid
  end

  it 'Returns 3 most recent post' do
    subject.posts.create(title: 'Hey', text: 'This is my first post')
    subject.posts.create(title: 'Hey', text: 'This is my second post')
    subject.posts.create(title: 'Hey', text: 'This is my third post')
    subject.posts.create(title: 'Hey', text: 'This is my fourth post')
    subject.posts.create(title: 'Hey', text: 'This is my fifth post')
    expect(subject.three_most_recent_posts.count).to eql(3)
  end
end