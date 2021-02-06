class User < ActiveRecord::Base
    has_secure_password
    has_many :plants
    validates :username, uniqueness: true

    def slug
        self.username.downcase.gsub(" ","-")
    end
    
    def self.find_by_slug(slug)
    self.all.find{ |user| user.slug == slug}
    end
    
end