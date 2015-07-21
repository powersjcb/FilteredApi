# Search Optional Filtering for a Search API

### Setup
Data imported into postgres database as ActiveRecord models.  Table indexed on query arguments. (price, bathrooms, bedrooms)

Since data contains GIS information, it would be good to extend postgres with [PostGIS](http://postgis.net/) if the data needed to be indexed spatially. This could be implemented with [PostGIS ActiveRecord Adaptor](https://github.com/rgeo/activerecord-postgis-adapter), which appears to be well supported.

### Querying

The route `/listings` accepts the options: `min_price, max_price, min_bed, max_bed, min_bath, max_bath` which create chaining queries.  The user inputs are coerced to integers and then passed as arguments to a `#where` method. The query input will be protected from arrays being injected into the query args and they will be properly SQL escaped by ActiveRecord's `.where' method.

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
