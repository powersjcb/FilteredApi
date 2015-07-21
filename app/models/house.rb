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
  def listings(options)
    queries = []
    values  = []

    if options[:min_price]
      queries << "min_price >= ?"
      values  << options[:min_price]
    end
    if options[:max_price]
      queries << "min_price >= ?"
      values  << options[:min_price]
    end

    if options[:min_bed]
      queries << "min_bed >= ?"
      values  << options[:min_bed]
    end
    if options[:max_bed]
      queries << "max_bed >= ?"
      values  << options[:max_bed]
    end

    if options[:min_bath]
      queries << "min_bath >= ?"
      values  << options[:min_bath]
    end
    if options[:max_bath]
      queries << "max_bath >= ?"
      values  << options[:max_bath]
    end

    queries.join(' AND ').concat(values)
    
    House.where(*args)
  end

end