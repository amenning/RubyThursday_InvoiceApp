class Invoice < ApplicationRecord
  belongs_to :vendor
  has_many :subscriptions
end
