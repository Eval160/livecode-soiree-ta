class Cat < ApplicationRecord
  has_one :adoption
  has_one_attached :photo
end
