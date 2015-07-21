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


  # options: min_price, max_price, min_bed, max_bed, min_bath, max_bath
  def self.listings(options)
    queries = []
    values  = []

    if options[:min_price]
      queries << "price >= ?"
      values  << options[:min_price]
    end
    if options[:max_price]
      queries << "price <= ?"
      values  << options[:max_price]
    end
    if options[:min_bed]
      queries << "bedrooms >= ?"
      values  << options[:min_bed]
    end
    if options[:max_bed]
      queries << "bedrooms <= ?"
      values  << options[:max_bed]
    end
    if options[:min_bath]
      queries << "bathrooms >= ?"
      values  << options[:min_bath]
    end
    if options[:max_bath]
      queries << "bathrooms <= ?"
      values  << options[:max_bath]
    end

    args = [queries.join(' AND ')].concat(values)

    if options[:page]
      House.where(*args).page(options[:page])
    else
      House.where(*args)
    end
  end

end
