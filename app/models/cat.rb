class Cat < ApplicationRecord
  has_one_attached :photo
  has_one :adoption
  has_one :owner, through: :adoption, source: :user

end
