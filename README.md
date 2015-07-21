# Optional Search Filtering API

### Setup
Data imported into postgres database as ActiveRecord models.  Table indexed on query
arguments. (price, bathrooms, bedrooms)

- Reminder: Heroku postgres hobby servers limit at 10k rows :smiley:


Since data contains GIS information, it would be good to extend postgres with [PostGIS](http://postgis.net/) if the data needed to be indexed spatially. This could be implemented with [PostGIS ActiveRecord Adaptor](https://github.com/rgeo/activerecord-postgis-adapter), which appears to be well supported.

### Querying with Filters

[Demo Query](https://secret-beach-2991.herokuapp.com/listings?min_price=100000&max_price=200000&min_bed=2&max_bed=2&min_bath=2&max_bath=2)

[Paginated Query](https://secret-beach-2991.herokuapp.com/listings?min_price=100000&max_price=200000&min_bed=2&max_bed=2&min_bath=2&max_bath=2&page=1)

The route `/listings` accepts the optional filters: `min_price, max_price, min_bed, max_bed, min_bath, max_bath` which are built into one SQL query.  The user inputs are coerced to integers and then passed as arguments to a `#where` method. The query inputs is protected by integer conversion and they will be properly SQL escaped by ActiveRecord's `.where' method.

[Conditionally constructed ActiveRecord query](app/models/house.rb)

```rb
# app/models/house.rb
def self.listings(options)
  queries = []
  values  = []

  if options[:min_price]
    queries << "price >= ?"
    values  << Integer(options[:min_price])
  end
  .
  .
  .
  if options[:max_bath]
    queries << "bathrooms <= ?"
    values  << Integer(options[:max_bath])
  end

  args = [queries.join(' AND ')].concat(values)

  if options[:page]
    House.where(*args).page(options[:page])
  else
    House.where(*args)
  end
end
```
