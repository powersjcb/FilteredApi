# == Schema Information
#
# Table name: houses
#
#  id         :integer          not null, primary key
#  street     :string           not null
#  status     :string           not null
#  price      :integer          not null
#  bedrooms   :integer          not null
#  bathrooms  :integer          not null
#  sq_ft      :integer          not null
#  lat        :float            not null
#  lng        :float            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class House < ActiveRecord::Base
  validates :street, :status, :price, :bedrooms,
    :bathrooms, :sq_ft, :lat, :lng, presence: true
end
