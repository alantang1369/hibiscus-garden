class Plant < ActiveRecord::Base
    belongs_to :user
    belongs_to :type

    def slug
        self.variety.downcase.gsub(" ","-")
    end
    
    def self.find_by_slug(slug)
    self.all.find{ |user| user.slug == slug}
    end
end
