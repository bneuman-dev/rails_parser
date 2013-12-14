class DomainRule < ActiveRecord::Base
	validates :url, presence: true, uniqueness: {case_sensitive: false}
end
