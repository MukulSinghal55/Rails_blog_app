class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :blog
    validates :message,presence: true
end
