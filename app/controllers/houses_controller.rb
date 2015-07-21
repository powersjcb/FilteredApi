class HousesController < ApplicationController
  def search
    @listings = House.listings(search_params)

    render template: 'houses/search.json.jbuilder'
  end

  private
  def search_params
    params.permit(:min_price, :max_price, :min_bed,
                  :max_bed, :min_bath, :max_bath, :page)
  end
end
