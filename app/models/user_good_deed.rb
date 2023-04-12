class UserGoodDeed < ApplicationRecord
  belongs_to :user
  belongs_to :good_deed
end
