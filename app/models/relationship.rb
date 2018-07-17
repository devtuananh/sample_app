class Relationship < ApplicationRecord
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name
  scope :followers, ->user_id{where follower_id: user_id}
end
