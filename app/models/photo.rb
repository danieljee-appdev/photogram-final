# == Schema Information
#
# Table name: photos
#
#  id             :integer          not null, primary key
#  caption        :text
#  comments_count :integer
#  image          :string
#  likes_count    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer
#
class Photo < ApplicationRecord
  has_many(:comments, { :class_name => "Comment", :foreign_key => "photo_id", :dependent => :destroy })
  has_many(:likes, { :class_name => "Like", :foreign_key => "photo_id", :dependent => :destroy })
  belongs_to(:owner, { :required => false, :class_name => "User", :foreign_key => "owner_id" })
  has_many(:fans, { :through => :likes, :source => :fan })

    def poster
    my_owner_id = self.owner_id

    matching_users = User.where({ :id => my_owner_id })

    the_user = matching_users.at(0)

    return the_user
  end
end
