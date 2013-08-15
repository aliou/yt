class Channel < ActiveRecord::Base
  validates :url, uniqueness: true
end
