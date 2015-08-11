class Squawk < ActiveRecord::Base
  belongs_to :user
  validates_length_of :body, maximum: 170
  before_create :replace_with_link

  def self.timeline(user)
    following_ids = user.all_following.collect(&:id)
    all_ids = following_ids << user.id
    Squawk.where(user_id: all_ids).order("created_at DESC")
  end

  def replace_with_link
    if get_matches
      get_matches.each do |match|
        self.body.gsub!(match, create_search_link(match))
      end
    end
  end

  def create_search_link(word)
    "<a href='search/#{word}'>#{word}</a>"
  end

  def get_matches
    self.body.scan(/\B~\w*[a-zA-Z]+\w*/)
  end

end
