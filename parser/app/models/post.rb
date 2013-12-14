class Post < ActiveRecord::Base
	validates :url, presence: true, uniqueness: {case_sensitive: false}
end
